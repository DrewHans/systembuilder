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

echo "Starting $0"

# safety checks
check_dependency "flatpak"
check_not_root

# software packages
install_flatpak "com.github.tchx84.Flatseal"
install_flatpak "org.mozilla.firefox"
install_flatpak "io.gitlab.librewolf-community"
install_flatpak "org.freedesktop.Platform.ffmpeg-full"
install_flatpak "org.gnome.baobab"  # Disk Usage Analyzer
install_flatpak "org.keepassxc.KeePassXC"
install_flatpak "com.belmoussaoui.Authenticator"  # Gnome Authenticator

# games
install_flatpak "com.mojang.Minecraft"
install_flatpak "net.minetest.Minetest"
# install_flatpak "net.veloren.airshipper"  # official Veloren launcher
# install_flatpak "org.xonotic.Xonotic"  # FPS game

# emulators
install_flatpak "org.libretro.RetroArch"
install_flatpak "com.snes9x.Snes9x"  # SNES Emulator
install_flatpak "org.ppsspp.PPSSPP"  # Sony PSP Emulator
install_flatpak "net.pcsx2.PCSX2"  # Sony PS2 Emulator
install_flatpak "net.rpcs3.RPCS3"  # Sony PS3 Emulator
install_flatpak "io.github.simple64.simple64"  # Nintendo 64 Emulator
install_flatpak "io.mgba.mGBA"  # Nintendo Game Boy Advance Emulator
install_flatpak "org.DolphinEmu.dolphin-emu"  # Nintendo GameCube / Wii Emulator
install_flatpak "org.citra_emu.citra"  # Nintendo 3DS Emulator
install_flatpak "org.yuzu_emu.yuzu"  # Nintendo Switch Emulator

echo "$0 finished"
