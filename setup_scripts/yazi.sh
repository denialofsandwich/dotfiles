#!/bin/bash
# Setup yazi a terminal based file browser

brew_manage yazi ffmpeg-full sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick-full font-symbols-only-nerd-font chafa exiftool
brew link ffmpeg-full imagemagick-full -f --overwrite

mkdir -p ~/.config/yazi/plugins
stow_manage_simple ~/.config/yazi

function yazi_add_plugin() {
  grep "$1" ~/.config/yazi/package.toml || ya pkg add "$1"
}

if [[ "$MODE" == "install" ]]; then
  yazi_add_plugin yazi-rs/plugins:chmod
  yazi_add_plugin yazi-rs/plugins:mount
  yazi_add_plugin uhs-robert/sshfs
  yazi_add_plugin AminurAlam/yazi-plugins:spot
  yazi_add_plugin AminurAlam/yazi-plugins:spot-video
  yazi_add_plugin AminurAlam/yazi-plugins:spot-audio
  yazi_add_plugin AminurAlam/yazi-plugins:spot-image
  yazi_add_plugin denialofsandwich/searchjump
  yazi_add_plugin BennyOe/tokyo-night

  ya pkg upgrade
fi
