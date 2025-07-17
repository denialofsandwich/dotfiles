#!/bin/bash

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

brew install tmux

if test -d ~/.tmux/plugins/tpm; then
  echo "tmux plugin manager is already installed"
  git pull
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  # To install plugins run <starter>I in tmux
fi

echo "Update stow"
popd
stow -d stow_packages -t ~ $name
