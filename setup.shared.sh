#!/bin/bash

pushd $(dirname $0)

git config --global rerere.enabled true
git config --global pull.rebase true

popd
