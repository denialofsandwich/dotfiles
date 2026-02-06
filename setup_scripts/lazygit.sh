#!/bin/bash
# Setup lazygit, a simple terminal UI for git commands. It provides a more intuitive way to manage your git repositories.

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS == "ubuntu" ]]; then
  if type lazygit; then
    echo "LazyGit is already installed"
  else
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit.tar.gz lazygit
  fi
else
  brew install lazygit
fi

echo "Update stow"
popd

if [[ $OS == "ubuntu" ]]; then
  mkdir -p ~/.config/lazygit
  stow -d stow_packages -t ~/.config/lazygit --$MODE $name
else
  mkdir -p ~/Library/Application\ Support/lazygit
  stow -d stow_packages -t ~/Library/Application\ Support/lazygit --$MODE $name
fi
