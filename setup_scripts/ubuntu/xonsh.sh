#!/bin/bash

pushd $(dirname $0)

echo -e "\033[33m### SETUP xonsh\033[0m"

sudo apt-get install -y stow \
  pipx lsd ripgrep bat curl zoxide

pipx install xonsh
pipx inject xonsh xontrib-fzf-completions xontrib-vox

if test -f ~/.local/share/fonts/HackNerdFont-Regular.ttf; then
  echo "HackNF already installed"
else
  mkdir -p ~/.local/share/fonts/
  pushd ~/.local/share/fonts/
  rm -f Hack*
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip
  unzip Hack.zip
  rm -f Hack.zip
  popd

  fc-cache -fv
fi

echo "Update stow"
popd
stow -d stow_packages -t ~ xonsh
