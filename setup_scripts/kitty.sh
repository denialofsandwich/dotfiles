#!/bin/bash
# Setup kitty, a fast gpu-based terminal emulator

brew_manage kitty

if [[ $OS_TYPE == "linux" ]]; then
  # The brew cask installs the kitty binary and app data, but doesn't register
  # a desktop file, so we need to do that ourselves.
  icon_dir=~/.local/share/icons/hicolor/256x256/apps
  if [[ $MODE == "install" ]]; then
    kitty_bin="$(brew --prefix)/bin/kitty"
    kitty_prefix="$(dirname "$(dirname "$(readlink -f "$kitty_bin")")")"
    mkdir -p ~/.local/share/applications "$icon_dir"
    cp "$kitty_prefix/share/icons/hicolor/256x256/apps/kitty.png" "$icon_dir/"
    cp "$kitty_prefix/share/applications/kitty.desktop" ~/.local/share/applications/
    cp "$kitty_prefix/share/applications/kitty-open.desktop" ~/.local/share/applications/
    sed -i "s|Exec=kitty|Exec=$kitty_bin|g" ~/.local/share/applications/kitty*.desktop
  else
    rm -f ~/.local/share/applications/kitty*.desktop "$icon_dir/kitty.png"
  fi
  command -v kbuildsycoca6 &>/dev/null && kbuildsycoca6 &>/dev/null

  mkdir -p ~/.kitty-sessions
fi

stow_manage_templated ~/.config/kitty
