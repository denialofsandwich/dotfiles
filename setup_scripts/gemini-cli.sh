#!/bin/bash
# Setup Gemini CLI, a tool to interact with Google's Gemini AI from the terminal. It allows you to leverage AI for various tasks directly in your workflow.
#
# Dependencies:
# - nvm.sh

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

brew $MODE gemini-cli
