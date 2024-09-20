#!/bin/bash

pushd $(dirname $0)

echo -e "\033[33m### SETUP vim\033[0m"

brew install stow vim

echo "Update stow"
popd
stow -d stow_packages -t ~ vim
