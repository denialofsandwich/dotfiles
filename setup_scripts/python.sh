#!/bin/bash
# Setup Python and its ecosystem, including pipx, ipython, and poetry. This script ensures you have a robust environment for Python development.

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS_TYPE == "linux" ]]; then
  sudo $LINUX_PKG_MGR install -y pipx
else
  brew install pipx
fi

type ipython || pipx install ipython
type poetry || pipx install poetry
type uv || pipx install uv
type pre-commit || pipx install pre-commit

echo "Update stow"
mkdir -p ~/.config/pypoetry
stow -d stow_packages -t ~/.config/pypoetry "--$MODE" poetry
