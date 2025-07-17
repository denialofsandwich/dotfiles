#!/bin/bash

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

brew install lazygit

echo "Update stow"
popd

mkdir -p ~/Library/Application\ Support/lazygit
stow -d stow_packages -t ~/Library/Application\ Support/lazygit $name
