#!/bin/bash
# Setup xonsh, a Python-powered, cross-platform, Unix-gazing shell language and command prompt. It combines the best of Python and shell scripting.
# Dependencies:
# - python.sh - To be able to use pipx

brew "$MODE" lsd bat ripgrep zoxide

pipx install xonsh
pipx inject xonsh xontrib-fzf-completions xontrib-vox prompt_toolkit gnureadline pygments

echo "Update stow"
stow -d stow_packages -t ~ "--$STOW_MODE" xonsh
