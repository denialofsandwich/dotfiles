#!/bin/bash
# Setup btop, an even more fancy version of top

brew "$MODE" -y btop
stow_update_simple ~/.config/btop
