#!/bin/bash
# Setup Neovim, a Vim-based text editor engineered for extensibility and usability. It aims to improve the editing experience while maintaining compatibility with Vim.
#
# Dependencies:
# - fzf.sh - Used by fzf-find plugin for anything search related
# - lazygit.sh - Configured as the default git manager (optional)
# - nerd-font.sh - Complex icon support
# - nvm.sh (ubuntu) - For the ast parser tree-sitter-cli
# - python.sh - For python based plugins. But currently unused (optional)
# - yazi.sh - To use the yazi file manager integration (optional)
# - zsh.sh - Configured as the default shell

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS_TYPE == "linux" ]]; then
  [[ $OS == "ubuntu" ]] && sudo apt-get install -y \
    luarocks fd-find ripgrep nodejs npm xclip wl-clipboard imagemagick texlive-latex-base
  [[ $OS == "fedora" ]] && sudo dnf install -y \
    luarocks fd-find ripgrep nodejs npm xclip wl-clipboard ImageMagick

  # Workaround if nvm was installed recently and the env vars not set yet
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  npm install -g tree-sitter-cli
  npm install -g @mermaid-js/mermaid-cli

  echo INSTALL neovim
  pushd "$HOME/.local/bin" || exit 1
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
  chmod u+x nvim-linux-x86_64.appimage
  mv nvim-linux-x86_64.appimage nvim
  popd
else
  brew install luarocks fd ripgrep nodejs npm tree-sitter tree-sitter-cli neovim python@3.12 imagemagick-full mermaid-cli
fi

[[ -d ~/.local/nvim/venv ]] || uv venv ~/.local/nvim/venv
uv pip install --python ~/.local/nvim/venv/bin/python pynvim

echo "Update stow"
mkdir -p ~/.config
stow -d stow_packages -t ~/.config "--$MODE" "$name"
