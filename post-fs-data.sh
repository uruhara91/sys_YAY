#!/system/bin/sh
MODDIR=${0%/*}

if [ -f "$MODDIR/core/yay_post.sh" ]; then
    sh "$MODDIR/core/yay_post.sh"
fi
