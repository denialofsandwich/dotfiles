#!/bin/bash
# Setup kitty, a fast gpu-based terminal emulator

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS_TYPE == "linux" ]]; then
  sudo $LINUX_PKG_MGR install -y kitty
else
  brew install kitty
  ln -s /opt/homebrew/Cellar/kitty/*/Kitty.app /Applications/ || true
fi

echo "Update stow"
mkdir -p ~/.config/kitty
if [[ $OS_TYPE == "linux" ]]; then
  stow -d stow_packages/kitty -t ~/.config/kitty "--$MODE" "linux"
else
  stow -d stow_packages/kitty -t ~/.config/kitty "--$MODE" "macos"
fi
