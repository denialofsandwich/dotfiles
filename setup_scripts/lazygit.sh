#!/bin/bash
# Setup lazygit, a simple terminal UI for git commands.

brew_manage lazygit delta

if [[ $OS_TYPE == "macos" ]]; then
  stow_manage_simple ~/Library/Application\ Support/lazygit
else
  stow_manage_simple ~/.config/lazygit
fi
