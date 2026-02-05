#!/bin/bash

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

brew install vim

echo "Update stow"
popd
stow -d stow_packages -t ~ --$MODE $name
