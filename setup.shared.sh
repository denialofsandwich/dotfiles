#!/bin/bash

pushd $(dirname $0)

git config --global rerere.enabled true
git config --global pull.rebase true

# possible modes are: stow, delete, restow
export MODE="${MODE:-stow}"

popd
