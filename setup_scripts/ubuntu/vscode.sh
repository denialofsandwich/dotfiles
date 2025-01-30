#!/bin/bash

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

sudo snap install --classic code

echo "Update stow"
stow -d ../../stow_packages -t ~ $name
