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

echo "Setting DNS addresses (sudo required)"


if [[ $(ls -1q /etc/NetworkManager/system-connections | wc -l) -eq 0 ]]; then
	echo "Error: there are no files in /etc/NetworkManager/system-connections"
	echo "DNS Addresses have not been set"
fi

if [[ $(ls -1q /etc/NetworkManager/system-connections | wc -l) -ne 0 ]]; then

	for f in /etc/NetworkManager/system-connections/*.nmconnection; do
		echo "Backing up $f"
		cp "$f" "$f.backup"

		echo "Updating wifi configuration in $f"

		# set wifi field
		patternStart="^\[wifi\]$"
		patternEnd="^mode=infrastructure$"

		insertText="\[wifi\]\n"
		insertText+="cloned-mac-address=random\n"
		insertText+="mode=infrastructure"

		sedPattern="/"
		sedPattern+="$patternStart"
		sedPattern+="/,/"
		sedPattern+="$patternEnd"
		sedPattern+="/c\\"
		sedPattern+="$insertText"

		sed -i -e "$sedPattern" "$f"


		# set ipv4 & ipv6 fields
		patternStart="^\[ipv4\]$"
		patternEnd="^\[proxy\]$"

		insertText="\[ipv4\]\n"
		insertText+="dns=9.9.9.9;149.112.112.112;1.1.1.1;1.0.0.1;\n"
		insertText+="ignore-auto-dns=true\n"
		insertText+="method=auto\n"
		insertText+="\n"
		insertText+="\[ipv6\]\n"
		insertText+="addr-gen-mode=stable-privacy\n"
		insertText+="dns=2620:fe::fe;2620:fe::9;2606:4700:4700::1111;2606:4700:4700::1001;\n"
		insertText+="ignore-auto-dns=true\n"
		insertText+="method=dhcp\n"
		insertText+="\n"
		insertText+="\[proxy\]"

		sedPattern="/$patternStart/,/$patternEnd/c\\$insertText"

		sed -i -e "$sedPattern" "$f"

		echo ""

	done

	echo "Restarting NetworkManager to load new configuration"
	systemctl restart NetworkManager
	echo ""

fi

echo "$0 has finished"
