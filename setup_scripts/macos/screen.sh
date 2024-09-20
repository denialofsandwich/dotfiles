#!/bin/bash

pushd $(dirname $0)

echo -e "\033[33m### SETUP screen\033[0m"

brew install stow screen

echo "Update stow"
popd
stow -d stow_packages -t ~ screen
