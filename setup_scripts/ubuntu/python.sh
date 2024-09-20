#!/bin/bash

pushd $(dirname $0)

echo -e "\033[33m### SETUP python\033[0m"

sudo apt-get install -y stow pipx build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev curl \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

if type pyenv; then
  echo "Pyenv is already installed"
else
  curl https://pyenv.run | bash
  git clone https://github.com/concordusapps/pyenv-implict.git ~/.pyenv/plugins/pyenv-implict
fi

type ipython || pipx install ipython
type poetry || pipx install poetry

echo "Update stow"
popd
stow -d stow_packages -t ~ poetry
