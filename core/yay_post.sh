#!/system/bin/sh

setprop() {
    resetprop "$1" "$2"
}

setprop dalvik.vm.systemuicompilerfilter speed-profile
setprop dalvik.vm.systemservercompilerfilter speed-profile
setprop dalvik.vm.dex2oat-minidebuginfo false
setprop dalvik.vm.minidebuginfo false
setprop debug.thermal.throttle.support no
setprop debug.hwui.skia_atrace_enabled false
setprop debug.atrace.tags.enableflags 0
setprop debug.camera.enhance_screen_brightness 0
setprop persist.sys.fflag.override.settings_enable_monitor_phantom_procs false
setprop ro.tran.hide.freezer 0

exit 0
