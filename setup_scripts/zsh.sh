#!/bin/bash
# Setup Zsh, a shell designed for interactive use with many features like advanced tab completion and globbing.

brew "$MODE" -y zsh lsd ripgrep bat zoxide fzf
stow_update_simple ~

if [[ "$MODE" == "install" ]]; then
  ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
  if [[ ! -d "$ZINIT_HOME" ]]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
  fi

  echo "Update zinit plugins"
  PAGER=cat GIT_PAGER=cat zsh -c "
    source '$ZINIT_HOME/zinit.zsh'
    fpath+=~/.zfunc
    zinit self-update -q
    zinit update --all --parallel -q
    zinit cclear
    rm -f ~/.zcompdump ~/.zcompdump.zwc
    autoload -Uz compinit
    compinit
  "
fi
