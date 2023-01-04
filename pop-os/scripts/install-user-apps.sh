#!/usr/bin/env bash


echo "Starting $0"

# exit if running as root
if [[ $(/usr/bin/id -u) -eq 0 ]]; then
	echo "Error: You should not run this script as root"
	exit 1
fi

echo "Setting up user apps"

echo "Updating flatpak"
flatpak update --assumeyes
echo ""

echo "Running preinstall scripts"
for f in ./apps/user/*/preinstall.sh; do
	echo "Running ${f}"
	bash $f
	echo ""
done

echo "Running install scripts"
for f in ./apps/user/*/install.sh; do
	echo "Running ${f}"
	bash $f
	echo ""
done

echo "Running postinstall scripts"
for f in ./apps/user/*/postinstall.sh; do
	echo "Running ${f}"
	bash $f
	echo ""
done

echo "$0 has finished"
