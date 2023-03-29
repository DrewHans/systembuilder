#!/usr/bin/env bash


if [ ! -f "/etc/apt/sources.list.d/wireshark-dev-ubuntu-stable-*.list" ]; then
	add-apt-repository ppa:wireshark-dev/stable
fi
