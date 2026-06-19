#!/bin/bash
# Setup lazygit, a simple terminal UI for git commands. It provides a more intuitive way to manage your git repositories.

brew "$MODE" lazygit delta

echo "Update stow"
if [[ $OS == "ubuntu" ]]; then
  mkdir -p ~/.config/lazygit
  stow -d stow_packages -t ~/.config/lazygit "--$STOW_MODE" "$MODULE"
else
  mkdir -p ~/Library/Application\ Support/lazygit
  stow -d stow_packages -t ~/Library/Application\ Support/lazygit "--$STOW_MODE" lazygit
fi
