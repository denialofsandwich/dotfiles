#!/bin/bash

pushd $(dirname $0)

echo -e "\033[33m### SETUP neovim\033[0m"

brew install stow luarocks fd ripgrep nodejs tree-sitter neovim lazygit

if python3 -c 'import pynvim'; then
  echo "pynvim already installed"
else
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"

  pyenv install -s 3.12
  pyenv virtualenv 3.12 pynvim
  pyenv activate pynvim
  python3 -m pip install pynvim
fi

echo "Update stow"
popd

pushd stow_packages/neovim/.config/nvim/lua/config
touch custom.lua
popd

stow -d stow_packages -t ~ neovim
