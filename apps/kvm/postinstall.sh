#!/usr/bin/env bash

# only members of the libvirt and kvm user groups should be able to run vms
sudo adduser "${SUDO_USER:-$USER}" libvirt
sudo adduser "[${SUDO_USER:-$USER}]" kvm

# note: you can remove users from these groups using deluser command

# verify installation with virsh:
# $ virsh list --all

# or verify installation with systemctl:
# $ sudo systemctl status libvirtd

# activate the virtualization daemon with systemctl:
# $ sudo systemctl enable --now libvirtd
