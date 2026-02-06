#!/bin/bash

# possible modes are: stow, delete, restow
export MODE="${MODE:-stow}"
export OS=macos
pushd $(dirname $0)

brew install htop lsof telnet jq stow

./setup.shared.sh
./setup_scripts/bash.sh
./setup_scripts/fzf.sh
./setup_scripts/nerd-font.sh
./setup_scripts/oh-my-posh.sh
./setup_scripts/zsh.sh
./setup_scripts/xonsh.sh
./setup_scripts/python.sh
./setup_scripts/screen.sh
./setup_scripts/tmux.sh
./setup_scripts/vim.sh
./setup_scripts/lazygit.sh
./setup_scripts/neovim.sh

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

popd
