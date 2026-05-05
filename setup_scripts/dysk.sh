#!/bin/bash
# Setup dysk, a Linux utility to get information on filesystems. It provides a better and more colorful way to view disk usage than df.

set -euo pipefail
name=$(basename -s .sh "$0")

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS_TYPE == "linux" ]]; then
  brew $MODE dysk
else
  echo No-op for macos
  exit 0
fi
