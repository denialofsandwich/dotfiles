#!/bin/bash
# Installs a dev container to create an isolated dev environment

brew_manage uv

if [[ "$OS_TYPE" == "macos" ]]; then
  brew_manage podman
elif [[ "$OS" == "fedora" ]]; then
  sudo dnf install -y podman crun-krun
fi

stow_manage_simple ~/.local/bin devc-bin
stow_manage_templated ~/.config/devc
