#!/bin/bash
# Setup GNU Screen, a terminal multiplexer that allows you to manage multiple terminal sessions within a single window. It's particularly useful for remote sessions.

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS == "ubuntu" ]]; then
  sudo apt-get install -y screen
else
  brew install screen
fi

echo "Update stow"
stow -d stow_packages -t ~ "--$MODE" "$name"
