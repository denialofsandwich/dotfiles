#!/bin/bash
# Setup Python and its ecosystem, including pipx, ipython, and poetry. This script ensures you have a robust environment for Python development.

brew "$MODE" pipx

type ipython || pipx install ipython
type poetry || pipx install poetry
type uv || pipx install uv
type pre-commit || pipx install pre-commit

echo "Update stow"
mkdir -p ~/.config/pypoetry
stow -d stow_packages -t ~/.config/pypoetry "--$STOW_MODE" poetry
