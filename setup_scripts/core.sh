#!/bin/bash
# Install core tools for my dotfiles

if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

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
