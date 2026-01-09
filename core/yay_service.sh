#!/system/bin/sh

sleep 10

LOG_DIR="/storage/emulated/0/Yokai/Logs"
LOG_FILE="/storage/emulated/0/Yokai/Logs/nightly-yokai.logs"

if [ ! -d "$LOG_DIR" ]; then mkdir -p "$LOG_DIR"; fi
echo "Yokai Service Started: $(date)" > "$LOG_FILE"

# === 1. SERVICE KILLER ===

TARGET_SERVICES="logcat logcatd logd loghid stats statsd traced idd-logreader idd-logreadermain dumpstate aplogd mobile_log_d netdiag aee_aed aee_aed64 connsyslogger tcpdump vendor.tcpdump"

for SERVICE in $TARGET_SERVICES; do
  stop "$SERVICE" 2>/dev/null
done

echo "Services stopped." >> "$LOG_FILE"

# === 2. KERNEL & DEBUG SILENCER ===

# Disable debug masks
find /sys/module /sys/kernel -type f \( -name "debug_mask" -o -name "log_level*" -o -name "debug_level*" -o -name "*debug_mode" -o -name "tracing_on" \) 2>/dev/null | while read -r filepath; do write "$filepath" "0"; done

# Kernel Specifics
write "/proc/sys/kernel/printk" "0 0 0 0"
write "/proc/sys/kernel/panic" "0"
write "/proc/sys/kernel/panic_on_oops" "0"
write "/proc/sys/kernel/printk_devkmsg" "off"
write "/proc/sys/kernel/sched_schedstats" "0"
write "/proc/sys/debug/exception-trace" "0"
write "/proc/sys/net/ipv4/tcp_no_metrics_save" "1"
write "/sys/module/spurious/parameters/noirqdebug" "1"

# Disable CRC
if [ -d "/sys/module/mmc_core/parameters" ]; then
    write "/sys/module/mmc_core/parameters/crc" "0"
    write "/sys/module/mmc_core/parameters/use_spi_crc" "0"
fi

# Ramdumps
if [ -d "/sys/module/subsystem_restart/parameters" ]; then
    write "/sys/module/subsystem_restart/parameters/enable_mini_ramdumps" "0"
    write "/sys/module/subsystem_restart/parameters/enable_ramdumps" "0"
fi

echo "Kernel Debug-CRC-Ramdumps Stopped." >> "$LOG_FILE"

# === 3. MEDIATEK TUNING ===

DVFSRC_PATH="/sys/devices/platform/10012000.dvfsrc/helio-dvfsrc"
MALI_PATH="/sys/class/misc/mali0/device"
GED_PATH="/sys/module/ged/parameters"
FPSGO_PATH="/sys/kernel/fpsgo"
GBE_PATH="/sys/kernel/gbe"
GBE_LIST="/sys/kernel/gbe/gbe_boost_list1"


# DVFSRC
if [ -d "$DVFSRC_PATH" ]; then
    write "$DVFSRC_PATH/dvfsrc_enable" "1"
fi

# Mali Power Policy
if [ -d "$MALI_PATH" ]; then
    write "$MALI_PATH/power_policy" "coarse_demand"
    write "$MALI_PATH/dvfs_enable" "1"
fi

# GBE
if [ -d "$GBE_PATH" ]; then
    write "$GBE_PATH/gbe_enable1" "1"
fi

if [ -f "$GBE_LIST" ]; then
    write "$GBE_LIST" "adbd adbd 100 0 0 0"
    write "$GBE_LIST" "app_process scrcpy.Server 100 0 0 0"
    write "$GBE_LIST" "com.garena.game.df MainThread-UE4 100 0 0 0"
fi

# GED
if [ -d "$GED_PATH" ]; then

    # Activate
    write "$GED_PATH/enable_gpu_boost" "1"
    write "$GED_PATH/boost_gpu_enable" "1"
    write "$GED_PATH/ged_smart_boost" "1"
    write "$GED_PATH/gpu_dvfs_enable" "1"
    write "$GED_PATH/enable_game_self_frc_detect" "0"
    write "$GED_PATH/gx_frc_mode" "0"
    write "$GED_PATH/gx_dfps" "0"
fi

# FPSGO
if [ -d "$FPSGO_PATH" ]; then
    write "$FPSGO_PATH/fbt/boost_ta" "1"
fi

echo "DVFSRC-MPP-GBE-GED-FPSGO Configured" >> "$LOG_FILE"

# === 4. MTK PPM (POWER POLICY) ===

PPM_PATH="/proc/ppm"

if [ -d "/proc/ppm" ]; then
    write "/proc/ppm/enabled" "1"
    write "/proc/ppm/policy/user_limit" "1" 
fi

echo "PPM Configured." >> "$LOG_FILE"

# === 5. I/O SCHEDULER ===

for queue in /sys/block/*/queue; do
    if echo "$queue" | grep -qE "loop|ram"; then
        continue
    fi

    # a. Checking
    AVAILABLE=$(cat "$queue/scheduler")
    SELECTED=""

    # b. Priority Logic
    if echo "$AVAILABLE" | grep -q "mq-deadline"; then
        SELECTED="mq-deadline"
    elif echo "$AVAILABLE" | grep -q "deadline"; then
        SELECTED="deadline"
    elif echo "$AVAILABLE" | grep -q "kyber"; then
        SELECTED="kyber"
    elif echo "$AVAILABLE" | grep -q "noop"; then
        SELECTED="noop"
    else
        SELECTED="none"
    fi

    # Set Scheduler
    if [ ! -z "$SELECTED" ]; then
        write "$queue/scheduler" "$SELECTED"
    fi

    # c. Global Tweak
    write "$queue/iostats" "0"
    write "$queue/add_random" "0"
done

echo "I/O Sched Configured." >> "$LOG_FILE"

# === 6. SYSCTL ===

# a. TCP Low Latency
write "/proc/sys/net/ipv4/tcp_low_latency" "1"
write "/proc/sys/net/ipv4/tcp_nodelay" "1"
write "/proc/sys/net/ipv4/tcp_timestamps" "0"

# b. Congestion Control
if [ -f "/proc/sys/net/ipv4/tcp_available_congestion_control" ]; then
    if grep -q "bbr" /proc/sys/net/ipv4/tcp_available_congestion_control; then
        write "/proc/sys/net/ipv4/tcp_congestion_control" "bbr"
    else
        write "/proc/sys/net/ipv4/tcp_congestion_control" "cubic"
    fi
fi

echo "Network & Sysctl Configured." >> "$LOG_FILE"

# === 7. MEMORY (VM) MANAGEMENT ===

write "/proc/sys/vm/swappiness" "50"
write "/proc/sys/vm/page-cluster" "0"
write "/sys/block/zram0/queue/iostats" "0"
write "/sys/block/zram0/queue/add_random" "0"

echo "VM Configured." >> "$LOG_FILE"

# === 8. SETTINGS TWEAKS ===

cmd settings put global mobile_data_always_on 0
cmd settings put system nearby_scanning_enabled 0

echo "Settings Configured." >> "$LOG_FILE"

# === 9. GAME LOG FIX ===

(
    # Config
    MAIN_DIR="/data/media/0/Android/data/com.garena.game.df/files"
    UE4_TARGET="$MAIN_DIR/UE4Game/DeltaForce/DeltaForce/Saved/Logs"
    INTL_TARGET="$MAIN_DIR/log"

    # Wait Game Dir
    TIMER=0
    while [ ! -d "$MAIN_DIR" ]; do
        sleep 2; TIMER=$((TIMER + 2))
        [ $TIMER -ge 20 ] && break
    done
    sleep 3

    # --- LOGIKA 1: UE4 (Folder -> File -> Null) ---
    if [ -d "$UE4_TARGET" ]; then rm -rf "$UE4_TARGET"; fi
    
    if [ ! -e "$UE4_TARGET" ]; then
        mkdir -p "$(dirname "$UE4_TARGET")"
        touch "$UE4_TARGET"
    fi
    
    mount -o bind /dev/null "$UE4_TARGET"
    echo "UE4 Log dir nap." >> "$LOG_FILE"

    # --- LOGIKA 2: INTL (Folder -> File -> Null) ---
    if [ -d "$INTL_TARGET" ]; then rm -rf "$INTL_TARGET"; fi

    if [ ! -e "$INTL_TARGET" ]; then
        touch "$INTL_TARGET"
    fi

    mount -o bind /dev/null "$INTL_TARGET"
    echo "INTL Log dir nap." >> "$LOG_FILE"

) &

echo "Game Log Napped." >> "$LOG_FILE"

# === 10. Undervolt === #

# echo "-6" > /proc/eem/EEM_DET_L/eem_offset
# echo "-6" > /proc/eem/EEM_DET_B/eem_offset

# echo "Undervolted." >> "$LOG_FILE"

# === 11. FSTrim ==

(
  sleep 60
  fstrim -v /data >> "$LOG_FILE" 2>&1 &
  fstrim -v /cache >> "$LOG_FILE" 2>&1 &
  fstrim -v /system >> "$LOG_FILE" 2>&1 &
  fstrim -v /vendor >> "$LOG_FILE" 2>&1 &

  for part in odm product metadata system_ext tranfs; do
      fstrim -v "/$part" >> "$LOG_FILE" 2>&1 &
  done
) &

echo "Trimmed." >> "$LOG_FILE"

# === 12. OTA ===

sleep 5

if [ -d "/data/gsi/ota" ]; then
    mount -o bind /dev/null /data/gsi/ota
fi

echo "OTA Disabled." >> "$LOG_FILE"

echo "Core Optimization Applied." >> "$LOG_FILE"

# === 13. CHAIN ===

CORE_DIR=$(dirname "$0")
RULES="$CORE_DIR/yay_rules.sh"
LAYA="$CORE_DIR/yay_laya.sh"
MON="$CORE_DIR/yay_mon"

export LOG_FILE

if [ -f "$RULES" ]; then
    echo "Chaining Rules (Background)..." >> "$LOG_FILE"
    sh "$RULES" &
else
    echo "Rules set not found" >> "$LOG_FILE"
fi

if [ -f "$LAYA" ]; then
    echo "Chaining Laya..." >> "$LOG_FILE"
    sh "$LAYA" &
else
    echo "Laya not found" >> "$LOG_FILE"
fi

if [ -f "$MON" ]; then
    chmod 0755 "$MON"
    chown 0:0 "$MON"
    pkill -f "yay_mon"
    nohup "$MON" > /dev/null 2>&1 &
    echo "Abyss Monitor Started from Core Dir." >> "$LOG_FILE"
else
    echo "ERROR: yay_mon binary not found in $CORE_DIR" >> "$LOG_FILE"
fi

exit 0
