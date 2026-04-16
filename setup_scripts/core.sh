#!/bin/bash
# Install core tools for my dotfiles

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS_TYPE == "linux" ]]; then
  [[ $OS == "ubuntu" ]] && sudo apt update
  sudo $LINUX_PKG_MGR install -y htop lsof curl jq stow zip git
else
  brew install htop lsof telnet jq stow
fi

git config --global rerere.enabled true
git config --global pull.rebase true
