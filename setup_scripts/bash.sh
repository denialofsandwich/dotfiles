#!/bin/bash
# Setup Bash, the Bourne Again SHell. It's the default command language for most Linux distributions.

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

brew install bash

echo "Update stow"
stow -d stow_packages -t ~ "--$MODE" "$name"
