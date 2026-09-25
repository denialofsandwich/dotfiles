#!/bin/bash
# Setup tmux, a terminal multiplexer

brew_manage tmux
stow_manage_templated ~

if [[ "$MODE" == "install" ]]; then
  if test -d ~/.tmux/plugins/tpm; then
    echo "tmux plugin manager is already installed"
    pushd ~/.tmux/plugins/tpm >/dev/null || exit 1
    git pull
    popd >/dev/null || exit 1
  else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi

  echo "Update tmux plugins"
  ~/.tmux/plugins/tpm/bin/install_plugins
  ~/.tmux/plugins/tpm/bin/update_plugins all
fi
