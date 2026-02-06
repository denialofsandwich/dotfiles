#!/bin/bash
# Setup Neovim, a Vim-based text editor engineered for extensibility and usability. It aims to improve the editing experience while maintaining compatibility with Vim.
#
# Dependencies:
# - nvm.sh

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS == "ubuntu" ]]; then
  sudo apt-get install -y \
    flatpak luarocks fd-find ripgrep nodejs npm xclip wl-clipboard

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  npm install -g tree-sitter-cli

  echo INSTALL neovim
  pushd $HOME/.local/bin
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
  chmod u+x nvim-linux-x86_64.appimage
  mv nvim-linux-x86_64.appimage nvim
  popd

  if test -f ~/.local/nvim/venv/bin/python; then
    echo "pynvim already installed"
  else
    eval "$(pyenv init -)"
    pyenv install -s 3.12
    mkdir -p ~/.local/nvim
    python3.12 -m venv ~/.local/nvim/venv
    ~/.local/nvim/venv/bin/pip install pynvim
  fi
else
  brew install luarocks fd ripgrep nodejs npm tree-sitter tree-sitter-cli neovim python@3.12

  if test -f ~/.local/nvim/venv/bin/python; then
    echo "pynvim already installed"
  else
    mkdir -p ~/.local/nvim
    python3.12 -m venv ~/.local/nvim/venv
    ~/.local/nvim/venv/bin/pip install pynvim
  fi
fi

echo "Update stow"
popd

pushd stow_packages/neovim/nvim/lua/config
test -f custom.lua || echo "return {}" >custom.lua
popd

mkdir -p ~/.config
stow -d stow_packages -t ~/.config --$MODE $name
