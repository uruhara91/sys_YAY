#!/system/bin/sh

CORE_DIR=$(dirname "$0")
LOG_FILE="/storage/emulated/0/Yokai/Logs/nightly-yokai.logs"

LIST_APPOPS="$CORE_DIR/appops.json"
LIST_COMPONENTS="$CORE_DIR/components.json"

log_msg() {
    echo "$1" >> "$LOG_FILE"
}

log_msg "=== Applying Rules ==="

if [ -f "$LIST_APPOPS" ]; then sed -i 's/\r$//' "$LIST_APPOPS"; fi
if [ -f "$LIST_COMPONENTS" ]; then sed -i 's/\r$//' "$LIST_COMPONENTS"; fi

# APPOPS
if [ -f "$LIST_APPOPS" ]; then
    log_msg "Processing AppOps..."
    while read -r PACKAGE OP MODE; do
        [ -z "$PACKAGE" ] && continue
        cmd appops set "$PACKAGE" "$OP" "$MODE"
    done < "$LIST_APPOPS"
else
    log_msg "Warn: appops.json missing"
fi

# COMPONENTS
if [ -f "$LIST_COMPONENTS" ]; then
    log_msg "Processing Components..."
    while read -r COMPONENT; do
        [ -z "$COMPONENT" ] && continue
        cmd package disable "$COMPONENT" >/dev/null 2>&1
    done < "$LIST_COMPONENTS"
else
    log_msg "Warn: components.json missing"
fi

log_msg "Rules Applied."
exit 0
