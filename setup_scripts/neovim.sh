#!/bin/bash
# Setup Neovim, a Vim-based text editor engineered for extensibility and usability. It aims to improve the editing experience while maintaining compatibility with Vim.
#
# Dependencies:
# - fzf.sh - Used by fzf-find plugin for anything search related
# - lazygit.sh - Configured as the default git manager (optional)
# - nerd-font.sh - Complex icon support
# - python.sh - For python based plugins. But currently unused (optional)
# - yazi.sh - To use the yazi file manager integration (optional)
# - zsh.sh - Configured as the default shell

brew "$MODE" -y luarocks fd ripgrep nodejs npm tree-sitter tree-sitter-cli neovim imagemagick-full mermaid-cli fzf

[[ -d ~/.local/nvim/venv ]] || uv venv ~/.local/nvim/venv
uv pip install --python ~/.local/nvim/venv/bin/python pynvim

echo "Update stow"
mkdir -p ~/.config
stow -d stow_packages -t ~/.config "--$STOW_MODE" neovim

if [[ "$MODE" == "install" ]]; then
  echo "Update lazy.nvim plugins"
  nvim --headless "+Lazy! sync" +qa

  echo "Update mason.nvim packages"
  nvim --headless -c "luafile misc/nvim-mason-update.lua" -c "qa"

  echo "Update nvim-treesitter parsers"
  nvim --headless "+TSUpdate" +qa
fi
