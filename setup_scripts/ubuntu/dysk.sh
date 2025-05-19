#!/bin/bash

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

pushd $HOME/.local/bin
curl -LO https://dystroy.org/dysk/download/x86_64-linux/dysk
chmod +x dysk
popd
