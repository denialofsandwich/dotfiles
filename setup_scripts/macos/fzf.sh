#!/bin/bash

pushd $(dirname $0)

echo -e "\033[33m### SETUP fzf\033[0m"

if test -d ~/.local/fzf; then
  echo "fzf is already installed."
else
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/fzf
  ~/.local/fzf/install --bin
fi
