#!/bin/bash
# Setup tmux, a terminal multiplexer that enables you to switch easily between several programs in one terminal. It also allows you to detach and reattach sessions.

brew "$MODE" -y tmux

if test -d ~/.tmux/plugins/tpm; then
  echo "tmux plugin manager is already installed"
  pushd ~/.tmux/plugins/tpm
  git pull
  popd
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  # To install plugins run <starter>I in tmux
fi

echo "Update stow"
stow -d stow_packages -t ~ "--$STOW_MODE" tmux
