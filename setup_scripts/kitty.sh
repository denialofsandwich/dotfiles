#!/bin/bash
# Setup kitty, a fast gpu-based terminal emulator

brew "$MODE" -y kitty

if [[ $OS_TYPE == "linux" ]]; then
  # The brew cask installs the kitty binary and app data, but doesn't register
  # a desktop file, so we need to do that ourselves.
  if [[ $MODE == "install" ]]; then
    kitty_prefix="$(dirname "$(dirname "$(readlink -f "$(brew --prefix)/bin/kitty")")")"
    cp "$kitty_prefix/share/applications/kitty.desktop" ~/.local/share/applications/
    cp "$kitty_prefix/share/applications/kitty-open.desktop" ~/.local/share/applications/
    sed -i "s|Icon=kitty|Icon=$kitty_prefix/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=$kitty_prefix/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
  else
    rm -f ~/.local/share/applications/kitty*.desktop
  fi

  mkdir -p ~/.kitty-sessions
fi

stow_update_templated ~/.config/kitty
