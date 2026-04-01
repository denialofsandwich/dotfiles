#!/bin/bash
# Setup yazi a terminal based file browser

set -euo pipefail
name=$(basename -s .sh "$0")
pushd "$(dirname "$0")"

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS == "ubuntu" ]]; then
  exit 0
  # implement for ubuntu
  # https://yazi-rs.github.io/docs/installation/#debian
else
  brew install yazi ffmpeg-full sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick-full font-symbols-only-nerd-font
  brew link ffmpeg-full imagemagick-full -f --overwrite
fi

# echo "Update stow"
# popd
#
# mkdir -p ~/.config/kitty
# stow -d stow_packages/kitty -t ~/.config/kitty "--$MODE" "macos"
