#!/bin/sh
MODDIR=${0%/*}

until [ "$(getprop sys.boot_completed)" = "1" ] && [ -f /data/system/packages.list ]; do
	sleep 1
done

if [ -f "$MODDIR/core/yay_service.sh" ]; then
    chmod +x "$MODDIR/core/yay_service.sh"
    chmod +x "$MODDIR/core/yay_rules.sh"
    chmod +x "$MODDIR/core/yay_laya.sh"
    sh "$MODDIR/core/yay_service.sh" &
fi

packages="$(sed 's|[]\"[]||g; s|,| |g' /data/adb/.config/sys_YAY/isolated.json)"
for apk in $packages; do
	uid="$(grep "^$apk" /data/system/packages.list | awk '{print $2; exit}')"
	[ ! -z $uid ] && {
		iptables -I OUTPUT -m owner --uid-owner $uid -j REJECT
		ip6tables -I OUTPUT -m owner --uid-owner $uid -j REJECT
		# debug
		echo "sys_YAY: blocked $apk with uid: $uid" >>/dev/kmsg
	}
done
