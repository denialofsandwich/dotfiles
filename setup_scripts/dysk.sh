#!/bin/bash
# Setup dysk, a Linux utility to get information on filesystems. It provides a better and more colorful way to view disk usage than df.

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS == "ubuntu" ]]; then
  pushd $HOME/.local/bin
  curl -LO https://dystroy.org/dysk/download/x86_64-linux/dysk
  chmod +x dysk
  popd
fi
