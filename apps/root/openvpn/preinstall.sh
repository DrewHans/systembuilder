#!/usr/bin/env bash


required_symlink="/usr/bin/systemd-resolve"

if [ -L ${required_symlink} ] ; then
    # -L returns true if file exists and is symbolic link
    # do nothing
elif [ -e ${required_symlink} ] ; then
    # -e returns true if file exists regardless of type
    # do nothing
else
    echo "Creating resolvectl symbolic link to systemd-resolve"
    # create symlink to fix nordvpn connection issue
    ln -s /usr/bin/resolvectl /usr/bin/systemd-resolve
fi
