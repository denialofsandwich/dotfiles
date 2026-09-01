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

  # gamescope (Gaming Mode) doesn't route AltGr as ISO_Level3_Shift for
  # external keyboards - it comes through with the "alt" modifier
  kitty_args+=(-o 'map=alt+q send_text all @')
  kitty_args+=(-o 'map=alt+< send_text all |')
  kitty_args+=(-o 'map=alt+e send_text all €')
  kitty_args+=(-o 'map=alt+7 send_text all {')
  kitty_args+=(-o 'map=alt+8 send_text all [')
  kitty_args+=(-o 'map=alt+9 send_text all ]')
  kitty_args+=(-o 'map=alt+0 send_text all }')
  kitty_args+=(-o 'map=alt+ß send_text all \\')
  kitty_args+=(-o 'map=alt+plus send_text all ~')
fi

exec /home/deck/.local/kitty.app/bin/kitty "${kitty_args[@]}"
