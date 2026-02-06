#!/bin/bash
# Setup Nerd Fonts, which patches developer targeted fonts with a high number of glyphs (icons). It's essential for a visually rich terminal experience.

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS == "ubuntu" ]]; then
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
else
  brew install --cask font-hack-nerd-font
fi
