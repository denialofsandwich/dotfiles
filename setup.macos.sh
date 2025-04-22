#!/bin/bash

pushd $(dirname $0)

brew install htop lsof telnet jq stow

./setup_scripts/macos/bash.sh
./setup_scripts/macos/fzf.sh
./setup_scripts/macos/nerd-font.sh
./setup_scripts/macos/oh-my-posh.sh
./setup_scripts/macos/zsh.sh
./setup_scripts/macos/xonsh.sh
./setup_scripts/macos/python.sh
./setup_scripts/macos/screen.sh
./setup_scripts/macos/tmux.sh
./setup_scripts/macos/vim.sh
#./setup_scripts/macos/vscode.sh
./setup_scripts/macos/neovim.sh

git config --global rerere.enabled true

# Manual fixes:
# - Set Font to "Hack Nerd Font"
# - nvim: Add iTerm2 > Profiles > Keys > Key Mappings:
#     <C-_> and <C-/> to Send Hex Code: 0x1f
# - disable bell in iterm2
# https://github.com/dmarcotte/easy-move-resize
#  brew install --cask easy-move-plus-resize
#  xattr -dr com.apple.quarantine /Applications/Easy\ Move+Resize.app
#
#  brew install iterm2
#    iterm remaps:
#    - left ctrl: left cmd
#    - left cmd: left ctrl
#
#  system > keyboard > repeat rate: max
#  system > keyboard > shortcuts > modifier (USB Keyboard):
#    - ctrl: cmd
#    - option: ctrl
#    - cmd: option
#  system > keyboard > shortcuts > modifier (Internal Keyboard):
#    - ctrl: cmd
#    - cmd: ctrl
