#!/usr/bin/env bash


# remove Ubuntu Pro Advantage garbage
apt remove ubuntu-advantage-tools --yes

if [ -f /usr/bin/pro ]
then
	rm /usr/bin/pro
fi

if [ -f /usr/share/man/man1/pro.1.gz ]
then
	rm /usr/share/man/man1/pro.1.gz
fi

if [ -f /etc/apt/apt.conf.d/20apt-esm-hook.conf ]
then
	mv /etc/apt/apt.conf.d/20apt-esm-hook.conf /etc/apt/apt.conf.d/20apt-esm-hook.conf.disabled
fi

apt autoremove --yes
