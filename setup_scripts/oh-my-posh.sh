#!/bin/bash
# Setup Oh My Posh, a custom prompt engine for any shell. It provides a highly customizable and themed prompt for your terminal.

brew "$MODE" -y oh-my-posh

echo "Update stow"
stow -d stow_packages -t ~ "--$STOW_MODE" oh-my-posh
