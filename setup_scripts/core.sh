#!/bin/bash
# Install core tools for my dotfiles

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"
command -v brew &>/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [[ $ROOT_PACKAGES == "yes" && $OS_TYPE == "linux" ]]; then
  sudo $LINUX_PKG_MGR install -y \
    htop lsof curl jq git vim screen tmux bash zsh
fi

brew install htop lsof curl jq stow zip git

if [[ $OS_TYPE == "macos" ]]; then
  brew install telnet
fi

git config --global rerere.enabled true
git config --global pull.rebase true
