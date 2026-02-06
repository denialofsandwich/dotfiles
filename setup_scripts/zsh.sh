#!/bin/bash
# Setup Zsh, a shell designed for interactive use with many features like advanced tab completion and globbing. It's a powerful alternative to Bash.

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS == "ubuntu" ]]; then
  sudo apt-get install -y \
    zsh lsd ripgrep bat curl zoxide
else
  brew install zsh lsd bat ripgrep zoxide
fi

echo "Update stow"
popd
stow -d stow_packages -t ~ --$MODE $name
