#!/usr/bin/env bash


command -v rustup >/dev/null 2>&1 && {
	echo "Detected rustup in path; updating installation..."
	rustup update
	echo ""
}

command -v rustup >/dev/null 2>&1 || {
	echo "Performing first-time installation setup..."
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	echo ""
}

command -v rustup >/dev/null 2>&1 && {
	echo "rustup version installed:"
	rustup --version
	echo ""
}

command -v cargo >/dev/null 2>&1 && {
	echo "cargo version installed:"
	cargo --version
	echo ""
}

command -v rustc >/dev/null 2>&1 && {
	echo "rustc version installed:"
	rustc --version
	echo ""
}

echo "Finished"

# source: https://www.rust-lang.org/tools/install
