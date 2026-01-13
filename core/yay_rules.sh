#!/system/bin/sh

CORE_DIR=$(dirname "$0")
LOG_FILE="/storage/emulated/0/Yokai/Logs/nightly-yokai.logs"

LIST_APPOPS="$CORE_DIR/appops.json"
LIST_COMPONENTS="$CORE_DIR/components.json"

if [ -x "/data/adb/magisk/busybox" ]; then
    XARGS="/data/adb/magisk/busybox xargs"
else
    # Fallback
    XARGS="xargs"
fi

echo "=== Applying Rules ===" >> "$LOG_FILE"

# 1. APPOPS
if [ -f "$LIST_APPOPS" ]; then
    echo "Processing AppOps..." >> "$LOG_FILE"
    cat "$LIST_APPOPS" | $XARGS -P 6 -n 3 cmd appops set
else
    echo "Warn: appops.json missing" >> "$LOG_FILE"
fi

# 2. COMPONENTS
if [ -f "$LIST_COMPONENTS" ]; then
    echo "Processing Components..." >> "$LOG_FILE"
    cat "$LIST_COMPONENTS" | $XARGS -P 6 -n 1 -I {} sh -c 'cmd package disable "{}" >/dev/null 2>&1'
else
    echo "Warn: components.json missing" >> "$LOG_FILE"
fi

echo "Rules Applied." >> "$LOG_FILE"
exit 0
