#!/bin/bash

pushd $(dirname $0)

echo -e "\033[33m### SETUP python\033[0m"

brew install openssl readline sqlite3 xz zlib tcl-tk

if type pyenv; then
  echo "Pyenv is already installed"
else
  curl https://pyenv.run | bash
  git clone https://github.com/concordusapps/pyenv-implict.git ~/.pyenv/plugins/pyenv-implict
fi

type ipython || pipx install ipython
type poetry || pipx install poetry
type pre-commit || pipx install pre-commit

echo "Update stow"
popd
stow -d stow_packages -t ~ poetry
