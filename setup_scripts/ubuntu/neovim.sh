#!/bin/bash

pushd $(dirname $0)

echo -e "\033[33m### SETUP neovim\033[0m"

sudo apt-get install -y stow \
  flatpak luarocks fd-find ripgrep nodejs tree-sitter-cli

echo INSTALL neovim
pushd $HOME/.local/bin
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage nvim
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

if python3 -c 'import pynvim'; then
  echo "pynvim already installed"
else
  pyenv install -s 3.12
  pyenv virtualenv 3.12 pynvim
  pyenv activate pynvim
  python3 -m pip install pynvim
fi

echo "Update stow"
popd

pushd stow_packages/neovim/.config/nvim/lua/config
test -f custom.lua || echo "return {}" >custom.lua
popd

stow -d stow_packages -t ~ neovim
