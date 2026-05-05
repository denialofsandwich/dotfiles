#!/bin/bash
# Setup dysk, a Linux utility to get information on filesystems. It provides a better and more colorful way to view disk usage than df.

if [[ $OS_TYPE == "linux" ]]; then
  brew "$MODE" dysk
else
  echo No-op for macos
fi
