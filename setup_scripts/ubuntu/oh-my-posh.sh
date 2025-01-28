#!/bin/bash
name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

mkdir -p ~/.local/bin
if [[ ! -f ~/.local/bin/oh-my-posh ]]; then
  curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
else
  echo "oh-my-posh already installed"
fi

echo "Update stow"
popd
stow -d stow_packages -t ~ $name
