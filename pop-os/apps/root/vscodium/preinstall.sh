#!/usr/bin/env bash

if [ ! -f "/usr/share/keyrings/vscodium-archive-keyring.gpg" ]; then
	mkdir -p /usr/share/keyrings/

	wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
	| gpg --dearmor \
	| sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

	chmod 644 /usr/share/keyrings/vscodium-archive-keyring.gpg
fi

if [ ! -f "/etc/apt/sources.list.d/vscodium.list" ]; then
	mkdir -p /etc/apt/sources.list.d/

	echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
	| sudo tee /etc/apt/sources.list.d/vscodium.list


	chmod 644 /etc/apt/sources.list.d/vscodium.list
fi
