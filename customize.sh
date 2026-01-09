ui_print "- Extracting module files"
unzip -p "$ZIPFILE" "laya-battery-monitor" > "$MODPATH/laya.battmon-service"
chmod +x "$MODPATH/laya.battmon-service"

ISOLATED="/data/adb/.config/sys_YAY/isolated.json"
if [ ! -f "$ISOLATED" ]; then
  mkdir -p "$(dirname "$ISOLATED")"
  touch "$ISOLATED"
fi

if [ "$KSU" = "true" ] || [ "$APATCH" = "true" ]; then
  rm -f "$MODPATH/action.sh"
  touch "$MODPATH/skip_mount"
  for dir in "/data/adb/ap/bin" "/data/adb/ksu/bin"; do
    if [ -d "$dir" ]; then
      ln -sf "/data/adb/modules/sys_YAY/system/bin/netswitch" "$dir/netswitch"
    fi
  done
fi

set_perm_recursive "$MODPATH/core" 0 0 0755 0755
set_perm_recursive "$MODPATH/system" 0 0 0755 0755
