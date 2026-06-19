#!/system/bin/sh

TARGET_SDK=31
TARGET_FP='Infinix/X6815B-OP/Infinix-X6815B:12/SP1A.210812.016/231020V486:user/release-keys'
CURRENT_SDK="$(getprop ro.build.version.sdk)"
CURRENT_FP="$(getprop ro.build.fingerprint)"

ui_print "*******************************"
ui_print " SystemUI MediaMetadata NPE Fix"
ui_print "*******************************"
ui_print "* Device SDK: $CURRENT_SDK"
ui_print "* Fingerprint: $CURRENT_FP"

[ "$CURRENT_SDK" = "$TARGET_SDK" ] || abort "! Unsupported Android SDK"
[ "$CURRENT_FP" = "$TARGET_FP" ] || abort "! Unsupported firmware fingerprint"

if [ -n "$KSU" ]; then
  ui_print "* KernelSU detected: a compatible Zygisk implementation is required"
else
  ui_print "* Ensure Zygisk is enabled in Magisk"
fi

ui_print "* Do not exclude com.android.systemui from Zygisk"
ui_print "* Reboot is required after installation"

set_perm_recursive "$MODPATH" 0 0 0755 0644
