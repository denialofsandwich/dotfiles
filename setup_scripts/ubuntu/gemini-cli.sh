#!/bin/bash

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

sudo apt-get install -y npm
npm install -g @google/gemini-cli

echo "Update stow"
popd
#stow -d stow_packages -t ~ $name
