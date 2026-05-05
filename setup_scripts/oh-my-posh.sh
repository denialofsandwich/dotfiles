#!/bin/bash
# Setup Oh My Posh, a custom prompt engine for any shell. It provides a highly customizable and themed prompt for your terminal.

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

brew install oh-my-posh

echo "Update stow"
stow -d stow_packages -t ~ "--$MODE" "$name"
