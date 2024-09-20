#!/bin/bash

pushd $(dirname $0)

echo -e "\033[33m### SETUP bash\033[0m"

sudo apt-get install -y stow bash

echo "Update stow"
popd
stow -d stow_packages -t ~ bash
