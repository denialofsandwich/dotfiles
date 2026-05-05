#!/bin/bash
# Setup lazygit, a simple terminal UI for git commands. It provides a more intuitive way to manage your git repositories.

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

brew install lazygit

echo "Update stow"
if [[ $OS == "ubuntu" ]]; then
  mkdir -p ~/.config/lazygit
  stow -d stow_packages -t ~/.config/lazygit "--$MODE" "$name"
else
  mkdir -p ~/Library/Application\ Support/lazygit
  stow -d stow_packages -t ~/Library/Application\ Support/lazygit "--$MODE" "$name"
fi
