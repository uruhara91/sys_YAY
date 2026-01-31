#!/system/bin/sh

CORE_DIR=$(dirname "$0")

LIST_COMPONENTS="$CORE_DIR/components.txt"
LIST_APPOPS="$CORE_DIR/appops.txt"

# COMPONENTS
if [ -f "$LIST_COMPONENTS" ]; then
    while read -r COMPONENT; do
        [ -z "$COMPONENT" ] && continue
        cmd package disable "$COMPONENT" >/dev/null 2>&1
    done < "$LIST_COMPONENTS"
else
    echo "Warn: components.txt Not Found" >> "$LOG_FILE"
fi

# APPOPS
if [ -f "$LIST_APPOPS" ]; then
    while read -r PACKAGE OP MODE; do
        [ -z "$PACKAGE" ] && continue
        cmd appops set "$PACKAGE" "$OP" "$MODE" >/dev/null 2>&1
    done < "$LIST_APPOPS"
else
    echo "Warn: appops.txt Not Found" >> "$LOG_FILE"
fi

echo "Components & Appops Applied." >> "$LOG_FILE"

exit 0
