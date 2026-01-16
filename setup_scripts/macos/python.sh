#!/bin/bash

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

brew install pipx

type ipython || pipx install ipython
type poetry || pipx install poetry
type pre-commit || pipx install pre-commit

echo "Update stow"
popd
mkdir -p ~/.config/pypoetry
stow -d stow_packages -t ~/.config/pypoetry poetry
