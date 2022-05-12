#!/usr/bin/env bash


curl -O https://zoom.us/client/latest/zoom_amd64.deb
apt install ./zoom_amd64.deb --yes
rm -f ./zoom_amd64.deb
