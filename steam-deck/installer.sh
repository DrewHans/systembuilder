#!/usr/bin/env bash


function check_dependency {
	if ! command -v "$1" > /dev/null 2>&1
	then
		echo "This script requires $1 to be installed."
		echo "Please use your distribution's package manager to install it."
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

function install_flatpak {
	flatpak install --user flathub "$1" --assumeyes
}

# safety checks
check_dependency "flatpak"
check_not_root

echo "Starting $0"

install_flatpak "io.gitlab.librewolf-community"
install_flatpak "org.freedesktop.Platform.ffmpeg-full"
install_flatpak "org.gnome.baobab"  # Disk Usage Analyzer
install_flatpak "org.keepassxc.KeePassXC"
install_flatpak "org.libretro.RetroArch"

echo "$0 finished"
