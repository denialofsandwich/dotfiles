#!/bin/bash
# Setup Vim, a highly configurable text editor for efficiently creating and changing any kind of text. It's built to be used both from a command line interface and as a standalone application.

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS == "ubuntu" ]]; then
  sudo apt-get install -y vim
else
  brew install vim
fi

echo "Update stow"
popd
stow -d stow_packages -t ~ --$MODE $name
