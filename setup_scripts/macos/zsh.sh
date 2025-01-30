#!/bin/bash

pushd $(dirname $0)

echo -e "\033[33m### SETUP zsh\033[0m"

brew install zsh lsd bat ripgrep zoxide

echo "Update stow"
popd
stow -d stow_packages -t ~ zsh
