#!/bin/sh
MODDIR=${0%/*}

until [ "$(getprop sys.boot_completed)" = "1" ]; do
	sleep 5
done

if [ -f "$MODDIR/core/yay_service.sh" ]; then
    chmod +x "$MODDIR/core/yay_service.sh"
    chmod +x "$MODDIR/core/yay_rules.sh"
    chmod +x "$MODDIR/core/yay_game.sh"
    sh "$MODDIR/core/yay_service.sh" &
fi

exit 0
