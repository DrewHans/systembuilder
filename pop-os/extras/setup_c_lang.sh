#!/usr/bin/env bash


sudo apt install build-essential manpages-dev --yes


command -v gcc >/dev/null 2>&1 && {
	echo "gcc version installed:"
	gcc --version
	echo ""
}

command -v g++ >/dev/null 2>&1 && {
	echo "g++ version installed:"
	g++ --version
	echo ""
}

command -v make >/dev/null 2>&1 && {
	echo "make version installed:"
	make --version
	echo ""
}

echo "Finished"
