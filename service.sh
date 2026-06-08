#!/bin/sh
MODDIR=${0%/*}

until [ "$(getprop sys.boot_completed)" = "1" ] && [ -f /data/system/packages.list ]; do
	sleep 5
done

if [ -f "$MODDIR/core/yay_service.sh" ]; then
    chmod +x "$MODDIR/core/yay_service.sh"
    chmod +x "$MODDIR/core/yay_rules.sh"
    chmod +x "$MODDIR/core/yay_game.sh"
    sh "$MODDIR/core/yay_service.sh" &
fi

JSON_FILE="/data/adb/.config/sys_YAY/isolated.json"

if [ -f "$JSON_FILE" ]; then
    packages="$(cat "$JSON_FILE" | tr -d '[]" ' | tr ',' ' ')"
    
    for apk in $packages; do
        uid="$(grep "^$apk" /data/system/packages.list | awk '{print $2; exit}')"
        
        if [ ! -z "$uid" ]; then
            iptables -C OUTPUT -m owner --uid-owner "$uid" -j REJECT 2>/dev/null || \
                iptables -I OUTPUT -m owner --uid-owner "$uid" -j REJECT
                
            ip6tables -C OUTPUT -m owner --uid-owner "$uid" -j REJECT 2>/dev/null || \
                ip6tables -I OUTPUT -m owner --uid-owner "$uid" -j REJECT
                
            # debug
            echo "sys_YAY: blocked $apk with uid: $uid" >>/dev/kmsg
        fi
    done
fi

exit 0
