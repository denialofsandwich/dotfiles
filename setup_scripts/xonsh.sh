#!/bin/bash
# Setup xonsh, a Python-powered, cross-platform, Unix-gazing shell language and command prompt. It combines the best of Python and shell scripting.
# Dependencies:
# - python.sh - To be able to use pipx

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS_TYPE == "linux" ]]; then
  sudo $LINUX_PKG_MGR install -y \
    lsd ripgrep bat curl zoxide
else
  brew install lsd bat ripgrep zoxide
fi

pipx install xonsh
pipx inject xonsh xontrib-fzf-completions xontrib-vox prompt_toolkit gnureadline pygments

echo "Update stow"
stow -d stow_packages -t ~ "--$MODE" "$name"
