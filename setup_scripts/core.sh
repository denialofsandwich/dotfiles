#!/bin/bash
# Install core tools for my dotfiles

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS == "ubuntu" ]]; then
  sudo apt update
  sudo apt-get install -y htop lsof curl entr jq stow zip
else
  brew install htop lsof telnet jq stow
fi
