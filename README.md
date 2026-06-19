# SystemUI MediaMetadata NPE Fix

Experimental Zygisk-only workaround for this TranSystemUI crash:

```text
FATAL EXCEPTION: SysUiBg
Process: com.android.systemui
java.lang.NullPointerException
  at com.android.systemui.media.MediaDataManager.loadMediaDataInBg(...)
```

## Supported target

- Device: Infinix X6815B
- Android: 12 / API 31
- ABIs packaged: arm64-v8a and armeabi-v7a
- Firmware fingerprint: `Infinix/X6815B-OP/Infinix-X6815B:12/SP1A.210812.016/231020V486:user/release-keys`
- SystemUI APK: `/system_ext/priv-app/TranSystemUI/TranSystemUI.apk`

Both the installer and native library refuse to hook a different SDK or fingerprint.

## How it works

The module only remains loaded in `com.android.systemui`. It hooks the native
`IPCThreadState::transact` Binder path and watches
`android.media.session.ISessionController.getMetadata`.

When a media session returns nullable `MediaMetadata` as `null`, the module
replaces that reply with a platform-generated empty `MediaMetadata` Parcel
before TranSystemUI reads it. This prevents the vendor's missing null-check from
terminating SystemUI.

There is no LSPosed, LSPlant, Java method hook, or modified SystemUI APK.

## Build on Windows PowerShell

Install Android NDK and set its path:

```powershell
$env:ANDROID_NDK_HOME = 'C:\Users\YOU\AppData\Local\Android\Sdk\ndk\27.2.12479018'
.\build.ps1
```

Or pass the path directly:

```powershell
.\build.ps1 -NdkPath 'D:\Android\ndk\27.2.12479018'
```

The flashable ZIP is written to:

```text
dist/SystemUI-Media-Fix-v0.1.0.zip
```

## Install and test

Flash the ZIP from Magisk, reboot, then capture focused logs:

```powershell
.\adb logcat -c
.\adb logcat -s SystemUIMediaFix:D AndroidRuntime:E
```

Expected startup messages:

```text
SystemUIMediaFix: Prepared empty MediaMetadata reply
SystemUIMediaFix: Hook installed
```

When the bad nullable response occurs:

```text
SystemUIMediaFix: Replaced null MediaMetadata Binder reply
```

Test Musicolet, MiXplorer, and closing the YouTube miniplayer separately.

## Recovery

If SystemUI becomes unstable, disable the module from ADB and reboot:

```powershell
.\adb shell su -c 'touch /data/adb/modules/systemui_media_fix/disable'
.\adb reboot
```

It can then be removed normally from the Magisk app.

## PowerShell note

A pipe after `adb shell` is handled by Windows PowerShell, so GNU `grep` is not
available there. Use either:

```powershell
.\adb shell dumpsys package com.android.systemui |
    Select-String 'versionName|versionCode'
```

or execute grep inside Android's shell:

```powershell
.\adb shell "dumpsys package com.android.systemui | grep -E 'versionName|versionCode'"
```
