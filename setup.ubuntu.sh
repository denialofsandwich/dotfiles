#!/bin/bash

# possible modes are: stow, delete, restow
export MODE="${MODE:-stow}"
export OS=ubuntu
pushd $(dirname $0)

sudo apt update
sudo apt-get install -y htop lsof curl entr jq stow zip

source ./setup.shared.sh

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
./setup_scripts/nvm.sh
./setup_scripts/neovim.sh
./setup_scripts/dysk.sh
./setup_scripts/gemini-cli.sh

popd
