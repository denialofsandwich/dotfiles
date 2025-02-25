#!/bin/bash

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

sudo apt-get install -y \
  flatpak luarocks fd-find ripgrep nodejs npm tree-sitter-cli xclip wl-clipboard

echo INSTALL neovim
pushd $HOME/.local/bin
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage nvim
popd

if type lazygit; then
  echo "LazyGit is already installed"
else
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
  rm lazygit.tar.gz lazygit
fi

if test -f ~/.local/nvim/venv/bin/python; then
  echo "pynvim already installed"
else
  eval "$(pyenv init -)"
  pyenv install -s 3.12
  mkdir -p ~/.local/nvim
  python3.12 -m venv ~/.local/nvim/venv
  ~/.local/nvim/venv/bin/pip install pynvim
fi

echo "Update stow"
popd

pushd stow_packages/neovim/.config/nvim/lua/config
test -f custom.lua || echo "return {}" >custom.lua
popd

stow -d stow_packages -t ~ $name
