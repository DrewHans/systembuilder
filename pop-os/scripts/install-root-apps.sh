#!/usr/bin/env bash


echo "Starting $0"

# exit if not running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
	echo "Error: You must run this script as root"
	exit 1
fi

echo "Setting up root apps (sudo required)"

echo "Running preinstall scripts"
for f in ./apps/root/*/preinstall.sh; do
	echo "Running ${f}"
	bash $f
	echo ""
done

echo "Running apt update"
apt update
echo ""

echo "Running install scripts"
for f in ./apps/root/*/install.sh; do
	echo "Running ${f}"
	bash $f
	echo ""
done

echo "Running postinstall scripts"
for f in ./apps/root/*/postinstall.sh; do
	echo "Running ${f}"
	bash $f
	echo ""
done

echo "Running apt clean"
apt clean --yes
echo ""

echo "Running apt autoremove"
apt autoremove --yes
echo ""

echo "Adding flathub to flatpak if it doesn't already exist"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "$0 has finished"
