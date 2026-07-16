#!/bin/bash
# Setup kitty, a fast gpu-based terminal emulator

if [[ $OS_TYPE == "linux" ]]; then
  if [[ $MODE == "install" ]]; then
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
    ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
    cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
    sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
  else
    rm -rf ~/.local/kitty.app
    rm ~/.local/bin/kitty ~/.local/bin/kitten
    rm ~/.local/share/applications/kitty*.desktop
  fi
else
  brew "$MODE" -y kitty
  ln -s /opt/homebrew/Cellar/kitty/*/Kitty.app /Applications/ || echo Not an error. Continuing...
fi

mkdir -p ~/.kitty-sessions

echo "Update stow"
mkdir -p ~/.config/kitty
if [[ $OS_TYPE == "linux" ]]; then
  stow -d stow_packages/kitty -t ~/.config/kitty "--$STOW_MODE" "linux"
else
  stow -d stow_packages/kitty -t ~/.config/kitty "--$STOW_MODE" "macos"
fi
