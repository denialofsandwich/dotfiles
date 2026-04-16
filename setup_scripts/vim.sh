#!/bin/bash
# Setup Vim, a highly configurable text editor for efficiently creating and changing any kind of text. It's built to be used both from a command line interface and as a standalone application.

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS_TYPE == "linux" ]]; then
  sudo $LINUX_PKG_MGR install -y vim
else
  brew install vim
fi

echo "Update stow"
stow -d stow_packages -t ~ "--$MODE" "$name"
