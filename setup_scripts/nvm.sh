#!/bin/bash
# Setup NVM (Node Version Manager), a tool to manage multiple active node.js versions. It allows you to easily switch between Node.js environments.

name=$(basename -s .sh $0)
pushd $(dirname $0)

echo -e "\033[33m### SETUP $name\033[0m"

if [[ $OS == "ubuntu" ]]; then
  export NVM_DIR="$HOME/.nvm"
  export PROFILE=/dev/null
  mkdir -p $NVM_DIR
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  nvm install --lts
  nvm alias default node
  nvm use default
fi

popd
