#!/bin/bash

pushd $(dirname $0)

echo -e "\033[33m### SETUP vim\033[0m"

sudo apt-get install -y stow vim

echo "Update stow"
popd
stow -d stow_packages -t ~ vim
