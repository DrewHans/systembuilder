#!/usr/bin/env bash


# pineflash is an app for updating the Pinecil soldering iron firmware

# grab latest pineflash deb file from github
curl -s https://api.github.com/repos/Spagett1/pineflash/releases/latest \
  | grep "browser_download_url.*deb" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -qi -

apt install ./*.deb

rm ./*.deb
