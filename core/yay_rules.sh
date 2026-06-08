#!/system/bin/sh

CORE_DIR=$(dirname "$0")
LIST_COMPONENTS="$CORE_DIR/components.txt"
LIST_APPOPS="$CORE_DIR/appops.txt"

HASH_FILE="$CORE_DIR/rules_hash.txt"

# Fungsi utama untuk mengeksekusi rules
apply_rules() {
    # COMPONENTS
    if [ -f "$LIST_COMPONENTS" ]; then
        while read -r COMPONENT || [ -n "$COMPONENT" ]; do
            [ -z "$COMPONENT" ] && continue
            cmd package disable "$COMPONENT" >/dev/null 2>&1
        done < "$LIST_COMPONENTS"
    else
        echo "Warn: components.txt Not Found" >> "$LOG_FILE"
    fi

    # APPOPS
    if [ -f "$LIST_APPOPS" ]; then
        while read -r PACKAGE OP MODE || [ -n "$PACKAGE" ]; do
            [ -z "$PACKAGE" ] && continue
            cmd appops set "$PACKAGE" "$OP" "$MODE" >/dev/null 2>&1
        done < "$LIST_APPOPS"
    else
        echo "Warn: appops.txt Not Found" >> "$LOG_FILE"
    fi

    echo "Components & Appops Applied." >> "$LOG_FILE"
}

# 1. Kalkulasi hash dari file saat ini
CURRENT_HASH=""
[ -f "$LIST_COMPONENTS" ] && CURRENT_HASH="$(md5sum "$LIST_COMPONENTS" | awk '{print $1}')"
[ -f "$LIST_APPOPS" ] && CURRENT_HASH="${CURRENT_HASH}_$(md5sum "$LIST_APPOPS" | awk '{print $1}')"

# 2. Baca hash yang tersimpan dari boot sebelumnya
SAVED_HASH=""
[ -f "$HASH_FILE" ] && SAVED_HASH="$(cat "$HASH_FILE")"

# 3. Bandingkan! Eksekusi HANYA JIKA ada perubahan di file txt.
if [ "$CURRENT_HASH" != "$SAVED_HASH" ]; then
    echo "Changes detected in rules. Applying new configuration..." >> "$LOG_FILE"
    apply_rules
    # Simpan hash baru agar boot berikutnya bisa di-skip
    echo "$CURRENT_HASH" > "$HASH_FILE"
else
    echo "Rules are unchanged. Skipping heavy Appops & Components execution." >> "$LOG_FILE"
fi

exit 0