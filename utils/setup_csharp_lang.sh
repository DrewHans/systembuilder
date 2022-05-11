#!/usr/bin/env bash


ubuntu_version=$(lsb_release --release --short)

command -v dotnet >/dev/null 2>&1 || {
    echo "Performing first-time installation setup..."

    curl -O https://packages.microsoft.com/config/ubuntu/$ubuntu_version/packages-microsoft-prod.deb

    if [ ! -f "packages-microsoft-prod.deb" ]; then
        echo "Failed to download packages-microsoft-prod.deb file; aborting"
        exit 1
    fi

    sudo dpkg -i packages-microsoft-prod.deb || {
        echo "Failed to install packages-microsoft-prod.deb; aborting"
        exit 1
    }

    rm packages-microsoft-prod.deb

    echo ""
}

sudo apt update

# install latest version of sdk 6.0
sudo apt install dotnet-sdk-6.0 --yes

command -v dotnet >/dev/null 2>&1 && {
    echo "dotnet info:"
    dotnet --info
    echo ""
}

echo "Finished"

# source: https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu
