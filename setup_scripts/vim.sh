#!/bin/bash
# Setup Vim, a highly configurable text editor for efficiently creating and changing any kind of text. It's built to be used both from a command line interface and as a standalone application.

brew "$MODE" vim

echo "Update stow"
stow -d stow_packages -t ~ "--$STOW_MODE" vim
