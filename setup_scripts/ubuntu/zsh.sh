#!/bin/bash

pushd $(dirname $0)

echo -e "\033[33m### SETUP zsh\033[0m"

sudo apt-get install -y stow \
  zsh lsd ripgrep bat curl zoxide

# Maybe some other time
# if test -d ~/.local/ohmyposh; then
#   echo "Oh My Posh is already installed"
# else
#   curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/ohmyposh
# fi

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

echo "Update stow"
popd
stow -d stow_packages -t ~ zsh
