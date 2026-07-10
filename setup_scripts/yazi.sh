#!/bin/bash
# Setup yazi a terminal based file browser

brew "$MODE" -y yazi ffmpeg-full sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick-full font-symbols-only-nerd-font chafa
brew link ffmpeg-full imagemagick-full -f --overwrite

ya pkg add yazi-rs/plugins:chmod || true
ya pkg add yazi-rs/plugins:mount || true
ya pkg add denialofsandwich/searchjump || true

echo "Update stow"
mkdir -p ~/.config/yazi
stow -d stow_packages -t ~/.config/yazi "--$STOW_MODE" yazi
