#!/bin/bash
# Setup Gemini CLI, a tool to interact with Google's Gemini AI from the terminal. It allows you to leverage AI for various tasks directly in your workflow.
#
# Dependencies:
# - nvm.sh

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS_TYPE == "linux" ]]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  npm install -g @google/gemini-cli
else
  brew install gemini-cli
fi
