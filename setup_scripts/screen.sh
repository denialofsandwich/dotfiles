#!/bin/bash
# Setup GNU Screen, a terminal multiplexer that allows you to manage multiple terminal sessions within a single window. It's particularly useful for remote sessions.

brew "$MODE" -y screen

echo "Update stow"
stow -d stow_packages -t ~ "--$STOW_MODE" screen
