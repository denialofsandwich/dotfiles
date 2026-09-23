#!/bin/bash
# A fancy kubernetes managing tool.

brew "$MODE" -y derailed/k9s/k9s

if [[ $OS_TYPE == "macos" ]]; then
  stow_update_simple ~/Library/Application\ Support/k9s
else
  stow_update_simple ~/.config/k9s
fi
