#!/bin/bash
# Setup fzf, a general-purpose command-line fuzzy finder. It's an interactive Unix filter for command-line that can be used with any list.

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

brew install fzf
