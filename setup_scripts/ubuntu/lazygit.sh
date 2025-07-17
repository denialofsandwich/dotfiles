#!/bin/bash

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

if type lazygit; then
  echo "LazyGit is already installed"
else
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
  rm lazygit.tar.gz lazygit
fi

echo "Update stow"
popd

mkdir -p ~/.config/lazygit
stow -d stow_packages -t ~/.config/lazygit $name
