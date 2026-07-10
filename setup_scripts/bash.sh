#!/bin/bash
# Setup Bash, the Bourne Again SHell. It's the default command language for most Linux distributions.

brew "$MODE" -y bash

echo "Update stow"
stow -d stow_packages -t ~ "--$STOW_MODE" bash
