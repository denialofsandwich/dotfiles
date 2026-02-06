#!/bin/bash
# Setup Python and its ecosystem, including pipx, ipython, and poetry. This script ensures you have a robust environment for Python development.

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS == "ubuntu" ]]; then
  sudo apt-get install -y pipx build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

  if type pyenv; then
    echo "Pyenv is already installed"
  else
    curl https://pyenv.run | bash
    git clone https://github.com/concordusapps/pyenv-implict.git ~/.pyenv/plugins/pyenv-implict
  fi
else
  brew install pipx
fi

type ipython || pipx install ipython
type poetry || pipx install poetry
type pre-commit || pipx install pre-commit

echo "Update stow"
popd
mkdir -p ~/.config/pypoetry
stow -d stow_packages -t ~/.config/pypoetry --$MODE poetry
