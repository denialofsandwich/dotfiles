#!/bin/bash
# Installs a dev container to create an isolated dev environment

brew_manage uv
if [[ "$OS_TYPE" == "macos" ]]; then
  brew_manage podman
fi

stow_manage_simple ~/.local/bin
