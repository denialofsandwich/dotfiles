#!/bin/bash
# Setup Python and its ecosystem, including pipx, ipython, and poetry. This script ensures you have a robust environment for Python development.

brew "$MODE" -y uv

type ipython || uv tool install ipython
type pre-commit || uv tool install pre-commit
type poetry || uv tool install poetry

echo "Update stow"
mkdir -p ~/.config/pypoetry
stow -d stow_packages -t ~/.config/pypoetry "--$STOW_MODE" poetry
