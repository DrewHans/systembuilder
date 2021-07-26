#!/usr/bin/env bash

curl -O https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb

sudo apt-get install ./nordvpn-release_1.0.0_all.deb --yes

sudo rm -f ./nordvpn-release_1.0.0_all.deb

