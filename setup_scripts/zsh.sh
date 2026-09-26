#!/bin/bash
# Setup Zsh, a shell designed for interactive use with many features like advanced tab completion and globbing.

brew_manage zsh lsd ripgrep bat zoxide fzf
stow_manage_simple ~

if [[ "$MODE" == "install" ]]; then
  ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
  if [[ ! -d "$ZINIT_HOME" ]]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
  fi

  echo "Install zinit plugins"
  PAGER=cat GIT_PAGER=cat script -qec "TERM=xterm zsh -i -c 'sleep 30; exit 0'" /dev/null >/dev/null

  echo "Update zinit plugins"
  PAGER=cat GIT_PAGER=cat zsh -c "
    source '$ZINIT_HOME/zinit.zsh'
    zinit self-update -q
    zinit update --all --parallel -q
    zinit cclear
    rm -f ~/.zcompdump ~/.zcompdump.zwc
    autoload -Uz compinit
    compinit
  "
  rm -f ~/.ssh/ssh-agent.env
fi
