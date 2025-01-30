#!/bin/bash

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

if test -f ~/.local/share/fonts/HackNerdFont-Regular.ttf; then
  echo "HackNF already installed"
else
  mkdir -p ~/.local/share/fonts/
  pushd ~/.local/share/fonts/
  rm -f Hack*
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip
  unzip Hack.zip
  rm -f Hack.zip
  popd

  fc-cache -fv
fi
