#!/bin/bash
# Setup kitty, a fast gpu-based terminal emulator

set -euo pipefail
name=$(basename -s .sh "$0")
pushd "$(dirname "$0")"

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS == "ubuntu" ]]; then
  sudo apt-get install -y kitty
else
  brew install kitty
  ln -s /opt/homebrew/Cellar/kitty/*/Kitty.app /Applications/
fi

echo "Update stow"
popd

mkdir -p ~/.config/kitty
stow -d stow_packages -t ~/.config/kitty "--$MODE" "$name"
