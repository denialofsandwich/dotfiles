#!/bin/bash
# Setup Zsh, a shell designed for interactive use with many features like advanced tab completion and globbing. It's a powerful alternative to Bash.

brew "$MODE" zsh lsd ripgrep bat zoxide fzf

echo "Update stow"
stow -d stow_packages -t ~ "--$STOW_MODE" zsh
