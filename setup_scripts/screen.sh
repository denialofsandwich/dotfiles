#!/bin/bash
# Setup GNU Screen, a terminal multiplexer that allows you to manage multiple terminal sessions within a single window. It's particularly useful for remote sessions.

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

brew $MODE screen

echo "Update stow"
stow -d stow_packages -t ~ "--$STOW_MODE" "$name"
