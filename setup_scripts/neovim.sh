#!/bin/bash
# Setup Neovim, a Vim-based text editor engineered for extensibility and usability.

brew "$MODE" -y luarocks fd ripgrep nodejs npm tree-sitter tree-sitter-cli neovim imagemagick-full mermaid-cli fzf
stow_update_simple ~/.config

if [[ "$MODE" == "install" ]]; then
  [[ -d ~/.local/nvim/venv ]] || uv venv ~/.local/nvim/venv
  uv pip install --python ~/.local/nvim/venv/bin/python pynvim

  echo "Update lazy.nvim plugins"
  nvim --headless "+Lazy! sync" +qa

  echo "Update mason.nvim packages"
  nvim --headless -c "luafile misc/neovim-mason-update.lua" -c "qa"

  echo "Update nvim-treesitter parsers"
  nvim --headless "+TSUpdate" +qa
fi
