#!/system/bin/sh

setprop() {
    resetprop "$1" "$2"
}

# === 1. PERFORMANCE & SYSTEM ===
setprop dalvik.vm.systemuicompilerfilter speed-profile
setprop dalvik.vm.systemservercompilerfilter speed-profile
setprop dalvik.vm.dex2oat-minidebuginfo false
setprop dalvik.vm.minidebuginfo false
setprop persist.sys.fflag.override.settings_enable_monitor_phantom_procs false
setprop debug.thermal.throttle.support no

# === 2. GRAPHICS & RENDERING ===
setprop debug.hwui.renderer skiagl
setprop debug.renderengine.backend skiaglthreaded
setprop debug.hwui.skia_atrace_enabled false

# === 3. LOGGER FIX ===
setprop persist.logd.size off
setprop persist.service.logd.enable false
setprop persist.traced.enable false
setprop logd.size off
setprop logd.logpersistd.enable false
setprop ro.logd.size off
setprop ro.logd.size.stats off
setprop ro.statsd.enable false

# === 4. MTK SPECIFIC ===
setprop persist.mtk.aee.mode 4
setprop persist.mtk.aee.filter 0
setprop persist.mtk.mobile_log.enable 0
setprop vendor.mtk.debug.level 0
setprop ro.tran.hide.freezer 0
setprop debug.camera.enhance_screen_brightness 0
setprop persist.sys.graphics.game_default 2

# === 5. UI ===
setprop disableBlurs 1
setprop persist.sys.sf.disable_blurs 1
setprop ro.tranos_hidenavigationbar_support 0
setprop ro.transsion_disable_launcher_unlock_support 0
setprop ro.transsion_enable_lite_launcher_unlock_support 0
setprop ro.os_hide_gesture_navigation_bar_support 0

exit 0
