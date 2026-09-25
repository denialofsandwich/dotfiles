#!/bin/bash
# A fancy kubernetes managing tool.

brew_manage derailed/k9s/k9s

if [[ $OS_TYPE == "macos" ]]; then
  stow_manage_simple ~/Library/Application\ Support/k9s
else
  stow_manage_simple ~/.config/k9s
fi
