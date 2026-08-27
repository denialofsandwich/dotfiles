#!/bin/bash
# A fancy kubernetes managing tool.

brew "$MODE" -y derailed/k9s/k9s

echo "Update stow"
if [[ $OS_TYPE == "linux" ]]; then
  mkdir -p ~/.config/lazygit
  stow -d stow_packages -t ~/.config/lazygit "--$STOW_MODE" k9s
else
  mkdir -p ~/Library/Application\ Support/k9s
  stow -d stow_packages -t ~/Library/Application\ Support/k9s "--$STOW_MODE" k9s
fi
