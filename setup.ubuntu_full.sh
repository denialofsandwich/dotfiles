#!/bin/bash

pushd $(dirname $0)

./setup.ubuntu.sh

sudo snap install telegram-desktop
flatpak permission-set webextensions org.kde.plasma.browser_integration snap.firefox yes

popd
