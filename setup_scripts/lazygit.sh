#!/bin/bash
# Setup lazygit, a simple terminal UI for git commands.

brew "$MODE" -y lazygit delta

if [[ $OS_TYPE == "macos" ]]; then
  stow_update_simple ~/Library/Application\ Support/lazygit
else
  stow_update_simple ~/.config/lazygit
fi
