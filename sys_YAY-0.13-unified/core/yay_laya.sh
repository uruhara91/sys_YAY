#!/system/bin/sh

echo "=== Applying Laya ===" >> "$LOG_FILE"

set -e
chmod +x /data/adb/modules/sys_YAY/laya.battmon-service
chmod 755 /data/adb/modules/sys_YAY/laya.battmon-service

if [ "$(getprop init.svc.laya_battmon)" = "running" ]; then
    stop laya_battmon
fi

if [ "$(getprop init.svc.laya_battmon_svc)" = "running" ]; then
    stop laya_battmon_svc
fi

## default = this is default configuration, devide cpu_maxfreq by 2
## false = this configuration disables default configuration, which mean no devide process was executed
## lowest = this configuration maxed out powersavimg by deviding cpu_maxfreq by 4 (example: 3000Mhz ÷ 4 = 750Mhz)
## If property was not set, it will automatically using the default one.
setprop persist.sys.laya.devide.cpufreq lowest

/data/adb/modules/sys_YAY/laya.battmon-service &

echo "Laya Applied." >> "$LOG_FILE"
