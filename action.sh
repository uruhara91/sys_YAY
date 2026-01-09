#!/bin/sh
if [ -z "$MMRL" ] && [ ! -z "$MAGISKTMP" ]; then
	pm path com.dergoogler.mmrl.wx >/dev/null 2>&1 && {
		echo "- Launching WebUI in MMRL WebUI..."
		am start -n "com.dergoogler.mmrl.wx/.ui.activity.webui.WebUIActivity" -e MOD_ID "sys_YAY"
		exit 0
	}
fi
exit 0
