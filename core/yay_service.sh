#!/system/bin/sh

sleep 10

LOG_DIR="/storage/emulated/0/Yokai/Logs"
LOG_FILE="/storage/emulated/0/Yokai/Logs/nightly-yokai.logs"

if [ ! -d "$LOG_DIR" ]; then mkdir -p "$LOG_DIR"; fi

# === FUNCTION DEFINITION ===
write() {
    if [ -w "$1" ]; then
        echo "$2" > "$1"
    fi
}

echo "Yokai Service Started: $(date)" > "$LOG_FILE"

# === 0. Kernel Silencer ===

for path in \
    "/proc/sys/kernel/printk" \
    "/proc/sys/kernel/printk_devkmsg" \
    "/proc/sys/kernel/sched_schedstats" \
    "/sys/module/spurious/parameters/noirqdebug" \
    "/proc/sys/debug/exception-trace"; do

    if [ -e "$path" ]; then
        case "$path" in
        *printk_devkmsg) val="off" ;;
        *printk) val="0 0 0 0" ;;
        *noirqdebug) val="1" ;;
        *) val="0" ;;
        esac
        write "$path" "$val"
    fi
done

echo "Kernel Silenced." >> "$LOG_FILE"

# === 1. I/O SCHEDULER ===

for queue in /sys/block/*/queue; do
    DEV_PATH="${queue%/queue}"
    DEV_NAME="${DEV_PATH##*/}"
    SCHED="$queue/scheduler"

    [ ! -f "$SCHED" ] && continue

    case "$DEV_NAME" in
        ram*|zram*|dm-*) continue ;;
        loop*)
            grep -q "none" "$SCHED" && echo "none" > "$SCHED"
            ;;
        *)
            AVAILABLE=$(cat "$SCHED")
            if echo "$AVAILABLE" | grep -q "kyber"; then
                echo "kyber" > "$SCHED"
            elif echo "$AVAILABLE" | grep -q "mq-deadline"; then
                echo "mq-deadline" > "$SCHED"
            elif echo "$AVAILABLE" | grep -q "deadline"; then
                echo "deadline" > "$SCHED"
            fi
            ;;
    esac

    echo "0" > "$queue/iostats"
    echo "0" > "$queue/add_random"
done

echo "I/O Sched Configured." >> "$LOG_FILE"

# === 2. SYSCTL ===

# Congestion Control
if grep -q "cubic" /proc/sys/net/ipv4/tcp_available_congestion_control 2>/dev/null; then
    write "/proc/sys/net/ipv4/tcp_congestion_control" "cubic"
fi

echo "Sysctl Configured." >> "$LOG_FILE"

# === 3. MEMORY (VM) MANAGEMENT ===

if [ -d "/sys/block/zram0" ]; then
    write "/sys/block/zram0/queue/iostats" "0"
    write "/sys/block/zram0/queue/add_random" "0"
fi

echo "VM Configured." >> "$LOG_FILE"

# === 3.5. UNDERVOLT ===

if [ -f "/proc/eem/EEM_DET_L/eem_offset" ]; then
    echo "-6" > /proc/eem/EEM_DET_L/eem_offset
    echo "-3" > /proc/eem/EEM_DET_B/eem_offset

    echo "Undervolt applied via EEM." >> "$LOG_FILE"
else
    echo "Undervolt interface not found." >> "$LOG_FILE"
fi

# === 4. FSTrim ===

( sleep 60; cmd sm fstrim ) &

echo "FSTrimed." >> "$LOG_FILE"

# === 5. OTA ===

OTA_TARGET="/data/gsi/ota"
if [ -d "$OTA_TARGET" ]; then
    rm -rf "$OTA_TARGET"
fi

if [ ! -e "$OTA_TARGET" ]; then
    mkdir -p "$(dirname "$OTA_TARGET")"
    touch "$OTA_TARGET"
fi
mount -o bind /dev/null "$OTA_TARGET"

echo "OTA freezed." >> "$LOG_FILE"

# === 6. CHAIN ===

CORE_DIR=$(dirname "$0")
RULES="$CORE_DIR/yay_rules.sh"
GAME="$CORE_DIR/yay_game.sh"

export LOG_FILE

if [ -f "$RULES" ]; then
    sh "$RULES" &
fi

if [ -f "$GAME" ]; then
    sh "$GAME" &
fi

echo "Chaining..." >> "$LOG_FILE"

exit 0
