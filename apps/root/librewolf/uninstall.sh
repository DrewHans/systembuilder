#!/usr/bin/env bash

apt remove librewolf --yes

rm -f \
    /etc/apt/sources.list.d/librewolf.list \
    /etc/apt/trusted.gpg.d/librewolf.gpg \
    /etc/apt/sources.list.d/home:bgstack15:aftermozilla.list \
    /etc/apt/trusted.gpg.d/home_bgstack15_aftermozilla.gpg
