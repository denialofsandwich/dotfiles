#!/bin/bash
# Setup xonsh, a Python-powered, cross-platform, Unix-gazing shell language and command prompt. It combines the best of Python and shell scripting.

set -euo pipefail
name=$(basename -s .sh "$0")
pushd "$(dirname "$0")"

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS == "ubuntu" ]]; then
  sudo apt-get install -y \
    pipx lsd ripgrep bat curl zoxide
else
  brew install pipx lsd bat ripgrep zoxide
fi

pipx install xonsh
pipx inject xonsh xontrib-fzf-completions xontrib-vox prompt_toolkit gnureadline pygments

echo "Update stow"
popd
stow -d stow_packages -t ~ "--$MODE" "$name"
