#!/usr/bin/env bash


function check_dependency {
	if ! command -v "$1" > /dev/null 2>&1
	then
		echo "This script requires $1 to be installed."
		echo "Please use your distribution's package manager to install it."
		exit 2
	fi
}

function check_is_root {
	if [[ $EUID -ne 0 ]]
	then
		echo "This script must be run as root."
		exit 1
	fi
}

# safety checks
check_is_root
check_dependency "git"

echo "Starting $0"

# install libmp3lame for ffmpeg mp3 encoding support
wget https://downloads.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz
tar -xvzf lame-3.100.tar.gz
cd lame-3.100
./configure
make
make install
cd ..

[ -f /usr/local/bin/lame ] || {
	echo "ERROR: lame not found at /usr/local/bin/lame"
	echo "Something went wrong... aborting"
	exit 1
}


# install nv-codec-headers for ffmpeg
git clone https://github.com/FFmpeg/nv-codec-headers.git
cd nv-codec-headers
make
make install
cd ..

[ -d /usr/local/include/ffnvcodec ] || {
	echo "ERROR: ffnvcodec directory not found at /usr/local/include/ffnvcodec"
	echo "Something went wrong... aborting"
	exit 1
}

# install ffmpeg
sudo apt-get install build-essential yasm cmake libtool libc6 libc6-dev unzip wget libnuma1 libnuma-dev

git clone https://git.ffmpeg.org/ffmpeg.git
cd ffmpeg
./configure --enable-nonfree --enable-cuda-nvcc --enable-libnpp --extra-cflags=-I/usr/local/cuda/include --extra-ldflags='-L/usr/local/cuda/lib64 -L/usr/local/lib' --disable-static --enable-shared
make -j 8
make install
cd ..
[ -f /usr/local/bin/ffmpeg ] || {
	echo "ERROR: ffmpeg not found at /usr/local/bin/ffmpeg"
	echo "Something went wrong... aborting"
	exit 1
}

