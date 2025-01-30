#!/bin/bash

pushd $(dirname $0)

sudo apt update
sudo apt-get install -y htop lsof curl entr jq stow
sudo snap install telegram-desktop

./setup_scripts/ubuntu/bash.sh
./setup_scripts/ubuntu/fzf.sh
./setup_scripts/ubuntu/nerd-font.sh
./setup_scripts/ubuntu/oh-my-posh.sh
./setup_scripts/ubuntu/zsh.sh
./setup_scripts/ubuntu/xonsh.sh
./setup_scripts/ubuntu/python.sh
./setup_scripts/ubuntu/screen.sh
./setup_scripts/ubuntu/tmux.sh
./setup_scripts/ubuntu/vim.sh
# ./setup_scripts/ubuntu/vscode.sh
./setup_scripts/ubuntu/neovim.sh

flatpak permission-set webextensions org.kde.plasma.browser_integration snap.firefox yes
