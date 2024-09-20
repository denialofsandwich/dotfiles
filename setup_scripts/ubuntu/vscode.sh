#!/bin/bash

pushd $(dirname $0)

echo -e "\033[33m### SETUP vscode\033[0m"

sudo apt-get install -y stow
sudo snap install --classic code

echo "Update stow"
stow -d ../../stow_packages -t ~ vscode
