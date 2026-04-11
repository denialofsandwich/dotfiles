#!/bin/bash
# Setup yazi a terminal based file browser

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS == "ubuntu" ]]; then
  sudo apt-get -y install ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick resvg

  pushd /tmp
  curl -LO https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.deb
  sudo dpkg --install yazi-x86_64-unknown-linux-gnu.deb
  rm yazi-x86_64-unknown-linux-gnu.deb
  popd
else
  brew install yazi ffmpeg-full sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick-full font-symbols-only-nerd-font
  brew link ffmpeg-full imagemagick-full -f --overwrite
fi

ya pkg add yazi-rs/plugins:chmod || true
ya pkg add yazi-rs/plugins:mount || true
ya pkg add dreammaomao/searchjump || true

echo "Update stow"
mkdir -p ~/.config/yazi
stow -d stow_packages -t ~/.config/yazi "--$MODE" "$name"
