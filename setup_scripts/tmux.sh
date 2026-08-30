#!/bin/bash
# Setup tmux, a terminal multiplexer that enables you to switch easily between several programs in one terminal. It also allows you to detach and reattach sessions.

brew "$MODE" -y tmux

if test -d ~/.tmux/plugins/tpm; then
  echo "tmux plugin manager is already installed"
  pushd ~/.tmux/plugins/tpm >/dev/null || exit 1
  git pull
  popd >/dev/null || exit 1
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  # To install plugins run <starter>I in tmux
fi

echo "Update stow"
mkdir -p stow_packages/tmux/configs
pushd stow_packages/tmux/templates >/dev/null || exit 1
jinja2 -D "FORCE_ZSH=$FORCE_ZSH" .tmux.conf.j2 >../configs/.tmux.conf
popd >/dev/null || exit 1
stow -d stow_packages/tmux -t ~ "--$STOW_MODE" configs
