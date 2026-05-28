#!/bin/bash
# Setup btop, an even more fancy version of top

brew "$MODE" btop

echo "Update stow"
mkdir -p ~/.config/btop
stow -d stow_packages -t ~/.config/btop "--$STOW_MODE" btop
