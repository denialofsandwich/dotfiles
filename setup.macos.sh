#!/bin/bash

pushd $(dirname $0)

brew install htop lsof telnet jq

./setup_scripts/macos/bash.sh
./setup_scripts/macos/fzf.sh
./setup_scripts/macos/zsh.sh
./setup_scripts/macos/python.sh
./setup_scripts/macos/screen.sh
./setup_scripts/macos/tmux.sh
./setup_scripts/macos/vim.sh
#./setup_scripts/macos/vscode.sh
./setup_scripts/macos/neovim.sh
