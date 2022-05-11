#!/usr/bin/env bash

# if nordvpn is not already installed
command -v nordvpn >/dev/null 2>&1 || {
    curl -O https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
    sudo apt install ./nordvpn-release_1.0.0_all.deb --yes
    sudo rm -f ./nordvpn-release_1.0.0_all.deb
}


required_symlink="/usr/bin/systemd-resolve"
if [ ! [ [ -L ${required_symlink} ] && [ -e ${required_symlink} ] ] ]; then
    # create symlink to fix nordvpn connection issue
    sudo ln -s /usr/bin/resolvectl /usr/bin/systemd-resolve
fi
