#!/bin/bash

pushd $(dirname $0)

echo -e "\033[33m### SETUP bash\033[0m"

brew install bash

echo "Update stow"
popd
stow -d stow_packages -t ~ bash
