#!/bin/bash

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

brew install stow luarocks fd ripgrep nodejs tree-sitter neovim lazygit python@3.12

if test -f ~/.local/nvim/venv/bin/python; then
  echo "pynvim already installed"
else
  mkdir -p ~/.local/nvim
  python3.12 -m venv ~/.local/nvim/venv
  ~/.local/nvim/venv/bin/pip install pynvim
fi

echo "Update stow"
popd

pushd stow_packages/neovim/.config/nvim/lua/config
test -f custom.lua || echo "return {}" >custom.lua
popd

stow -d stow_packages -t ~ neovim
