#!/bin/bash
# Setup Zsh, a shell designed for interactive use with many features like advanced tab completion and globbing. It's a powerful alternative to Bash.

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

brew install zsh lsd ripgrep bat zoxide

echo "Update stow"
stow -d stow_packages -t ~ "--$MODE" "$name"
