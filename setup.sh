#!/bin/bash

set -euo pipefail
pushd "$(dirname "$0")" || exit 1

export OS="unknown"
if [[ "$OSTYPE" == "darwin"* ]]; then
  export OS="macos"
elif [[ -f /etc/os-release ]]; then
  . /etc/os-release
  case "$ID" in
  ubuntu)
    export OS="ubuntu"
    ;;
  fedora)
    export OS="fedora"
    ;;
  esac
fi

if [[ "$OS" == "unknown" ]]; then
  echo "Error: Unsupported OS"
  exit 1
fi

DEFAULT_MODULES="
  core,
  bash,
  nerd-font,
  fzf,
  oh-my-posh,
  zsh,
  screen,
  tmux,
  vim,
  python,
  nvm,
  neovim,
  lazygit,
  yazi,
  kitty,
  dysk,
  xonsh,
  gemini-cli
"

# possible modes are: stow, delete, restow
export MODE="${MODE:-stow}"

export OS_TYPE="linux"
if [[ "$OS" == "macos" ]]; then
  export OS_TYPE="macos"
fi

export LINUX_PKG_MGR=apt-get
if [[ $OS == "fedora" ]]; then
  export LINUX_PKG_MGR=dnf
fi

MODULES=${MODULES:-$(echo "$DEFAULT_MODULES" | tr -d '[:space:]')}

for script in ${MODULES//,/ }; do
  bash "./setup_scripts/${script}.sh"
done

popd || exit 1
