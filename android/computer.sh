#!/usr/bin/env bash


function check_dependency {
	if ! command -v "$1" > /dev/null 2>&1
	then
		echo "This script requires $1 to be installed."
		exit 2
	fi
}

function check_not_root {
	if [[ $EUID -eq 0 ]]
	then
		echo "This script should not be run as root."
		exit 1
	fi
}

function apply_preferred_setting {
	if [ $(adb shell settings get $1) == "null" ]
	then
		echo "- WARNING: $1 is set to null; skipping"
		return 0
	fi

	echo "- $1"
	adb shell settings put $1 $2
}

# safety checks
check_not_root
check_dependency "adb"  # /Android/Sdk/build-tools should be in $PATH

echo "Starting $0"
echo ""

echo "Backing up device settings..."
adb shell settings list system > android_settings_system_backup.txt
adb shell settings list secure > android_settings_secure_backup.txt
adb shell settings list global > android_settings_global_backup.txt
echo "Backup saved."
echo ""

# see https://developer.android.com/reference/android/provider/Settings.System
echo "Applying preferred settings for system..."
apply_preferred_setting "system accelerometer_rotation" 0
apply_preferred_setting "system screen_brightness" 99
apply_preferred_setting "system screen_brightness_mode" 0
apply_preferred_setting "system show_touches" 1
apply_preferred_setting "system status_bar_show_battery_percent" 1
apply_preferred_setting "system user_rotation" 0
apply_preferred_setting "system vibrate_when_ringing" 1
apply_preferred_setting "system volume_alarm" 6
apply_preferred_setting "system volume_alarm_earpiece" 7
apply_preferred_setting "system volume_alarm_speaker" 1
apply_preferred_setting "system volume_bluetooth_sco" 7
apply_preferred_setting "system volume_bluetooth_sco_bt_a2dp" 4
apply_preferred_setting "system volume_music" 5
apply_preferred_setting "system volume_music_ble_headset" 5
apply_preferred_setting "system volume_music_bt_a2dp" 6
apply_preferred_setting "system volume_music_earpiece" 7
apply_preferred_setting "system volume_music_speaker" 0
apply_preferred_setting "system volume_music_usb_headset" 4
apply_preferred_setting "system volume_notification" 5
apply_preferred_setting "system volume_ring" 5
apply_preferred_setting "system volume_ring_earpiece" 7
apply_preferred_setting "system volume_ring_speaker" 0
apply_preferred_setting "system volume_system" 7
apply_preferred_setting "system volume_voice" 4
apply_preferred_setting "system volume_voice_ble_headset" 3
apply_preferred_setting "system volume_voice_earpiece" 2
apply_preferred_setting "system volume_voice_speaker" 1
echo "Preferred system settings applied."
echo ""

# see https://developer.android.com/reference/android/provider/Settings.Secure
echo "Applying preferred settings for secure..."
apply_preferred_setting "secure bluetooth_name" "iPhone"
echo "Preferred secure settings applied."
echo ""

# see https://developer.android.com/reference/android/provider/Settings.Global
echo "Applying preferred settings for global..."
apply_preferred_setting "global device_name" "iPhone"
apply_preferred_setting "global private_dns_mode" "hostname"
apply_preferred_setting "global private_dns_specifier" "dns.quad9.net"
echo "Preferred global settings applied."
echo ""

echo "Downloading latest F-Droid apk..."
wget https://f-droid.org/F-Droid.apk --output-document=./fdroid.apk --quiet
echo "Installing F-Droid..."
adb install ./fdroid.apk
echo "F-Droid install finished.
echo ""

echo "$0 finished"
