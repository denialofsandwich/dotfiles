#!/bin/bash
# Setup yazi a terminal based file browser

brew_manage yazi ffmpeg-full sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick-full font-symbols-only-nerd-font chafa exiftool
brew link ffmpeg-full imagemagick-full -f --overwrite
stow_manage_simple ~/.config/yazi

ya pkg upgrade
