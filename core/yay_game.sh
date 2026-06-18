#!/system/bin/sh

# === GAME LOG ===

(
    # Config
    MAIN_DIR="/data/media/0/Android/data/com.garena.game.df/files"
    UE4_TARGET="$MAIN_DIR/UE4Game/DeltaForce/DeltaForce/Saved/Logs"
    INTL_TARGET="$MAIN_DIR/log"
    CRYPTO_TARGET="$MAIN_DIR/logs"

    # Wait Game Dir
    TIMER=0
    while [ ! -d "$MAIN_DIR" ]; do
        sleep 2; TIMER=$((TIMER + 2))
        [ $TIMER -ge 20 ] && break
    done
    sleep 2

    # --- LOGIKA 1: UE4 ---
    if [ -d "$UE4_TARGET" ]; then rm -rf "$UE4_TARGET"; fi
    if [ ! -e "$UE4_TARGET" ]; then
        mkdir -p "$(dirname "$UE4_TARGET")"
        touch "$UE4_TARGET"
    fi
    mount -o bind /dev/null "$UE4_TARGET"

    # --- LOGIKA 2: INTL ---
    if [ -d "$INTL_TARGET" ]; then rm -rf "$INTL_TARGET"; fi
    if [ ! -e "$INTL_TARGET" ]; then
        mkdir -p "$(dirname "$INTL_TARGET")"
        touch "$INTL_TARGET"
    fi
    mount -o bind /dev/null "$INTL_TARGET"

    # --- LOGIKA 3: CRYPTO ---
    if [ -d "$CRYPTO_TARGET" ]; then rm -rf "$CRYPTO_TARGET"; fi
    if [ ! -e "$CRYPTO_TARGET" ]; then
        mkdir -p "$(dirname "$CRYPTO_TARGET")"
        touch "$CRYPTO_TARGET"
    fi
    mount -o bind /dev/null "$CRYPTO_TARGET"

) &

echo "Game Log Napped." >> "$LOG_FILE"

# Downscaler
#cmd game downscale 0.7 com.garena.game.df
#cmd game downscale 0.7 com.mobile.legends
#cmd game downscale 0.7 com.voodoo.almanac

echo "Game Mode Configured." >> "$LOG_FILE"

exit 0
