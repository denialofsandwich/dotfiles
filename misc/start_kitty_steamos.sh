#!/bin/bash

cd || exit 1

unset LD_PRELOAD
unset LD_LIBRARY_PATH
unset STEAM_RUNTIME
unset STEAM_RUNTIME_LIBRARY_PATH

export XKB_DEFAULT_LAYOUT=de
setxkbmap de >/dev/null 2>&1 || true

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

kitty_args=()
if systemctl --user is-active --quiet gamescope-session.service; then
  export NEOVIM_FORCE_DARK_THEME=yes
  kitty_args+=(--start-as=fullscreen)
fi

exec /home/deck/.local/kitty.app/bin/kitty "${kitty_args[@]}"
