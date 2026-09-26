#!/bin/bash
# Miscellaneous packages without an extra config

brew_manage htop lsof croc lazysql fastfetch

if [[ "$OS_TYPE" == "linux" ]]; then
  brew_manage dysk
elif [[ "$OS_TYPE" == "macos" ]]; then
  brew_manage telnet
fi
