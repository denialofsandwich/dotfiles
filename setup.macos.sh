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

# Manual fixes:
# - Set Font to "Hack Nerd Font"
# - nvim: Add iTerm2 > Profiles > Keys > Key Mappings for <C-_> and <C-/> to Send Hex Code: 0x1f
