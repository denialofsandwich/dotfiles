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
  steamos)
    export OS="steamos"
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
  oh-my-posh,
  zsh,
  screen,
  tmux,
  vim,
  python,
  neovim,
  lazygit,
  yazi,
  btop,
  kitty
"

export ROOT_PACKAGES="${ROOT_PACKAGES:-no}"

# possible modes are: install, uninstall
export MODE="${MODE:-install}"
[[ "$MODE" == "install" ]] && export STOW_MODE="stow"
[[ "$MODE" == "uninstall" ]] && export STOW_MODE="delete"

export OS_TYPE="linux"
if [[ "$OS" == "macos" ]]; then
  export OS_TYPE="macos"
fi

export LINUX_PKG_MGR=apt-get
if [[ $OS == "fedora" ]]; then
  export LINUX_PKG_MGR=dnf
fi

MODULES=${MODULES:-$(echo "$DEFAULT_MODULES" | tr -d '[:space:]')}

if [[ "$MODE" == "uninstall" ]]; then
  MODULES=$(
    echo "$MODULES" |
      tr ',' '\n' |
      tac |
      paste -sd ',' -
  )
fi

for module in ${MODULES//,/ }; do
  (
    set -euo pipefail
    echo -e "\033[33m### SETUP ${module}\033[0m"
    export MODULE=$module
    source "./setup_scripts/${module}.sh"
  )
done

popd || exit 1
