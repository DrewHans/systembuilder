#!/usr/bin/env bash


function check_is_root {
	if [[ $EUID -ne 0 ]]
	then
		echo "This script must be run as root."
		exit 1
	fi
}

echo "Starting $0"

# safety checks
check_is_root

echo "Enabling ssh..."
sudo touch ssh

echo "Setting up user account..."
sudo touch userconf

username="piuser"
password="raspberry"  # note: password login will get disabled later
encrypted_password=$(echo $password | openssl passwd -6 -stdin)

echo "$username:$encrypted_password" | sudo tee -a userconf > /dev/null

echo "Setting up wifi access..."
sudo touch wpa_supplicant.conf

wifi_ssid_name="REPLACE WITH WIFI SSID"
wifi_password="REPLACE WITH WIFI PASSWORD"

echo '
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=US

network={
 ssid="$wifi_ssid_name"
 psk="$wifi_password"
}
' | sudo tee -a wpa_supplicant.conf > /dev/null

echo "Finished $0"
