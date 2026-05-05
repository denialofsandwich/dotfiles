#!/bin/bash
# Install core tools for my dotfiles

command -v brew &>/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [[ $ROOT_PACKAGES == "yes" && $OS_TYPE == "linux" ]]; then
  sudo $LINUX_PKG_MGR install -y \
    htop lsof curl jq git vim screen tmux bash zsh
fi

brew "$MODE" htop lsof curl jq stow zip git

if [[ $OS_TYPE == "macos" ]]; then
  brew "$MODE" telnet
fi

git config --global rerere.enabled true
git config --global pull.rebase true
