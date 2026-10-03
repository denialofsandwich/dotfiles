export MODULES_DEFAULT=${MODULES_DEFAULT:-core bash nerd-font oh-my-posh zsh screen tmux vim python neovim lazygit misc devc yazi btop kitty}
# If yes, it explicitly sets the kitty and tmux shell to zsh
export FORCE_ZSH=${FORCE_ZSH:-yes}

export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export NC='\033[0m'

export OS="unknown"
if [[ "$OSTYPE" == "darwin"* ]]; then
  export OS="macos"
elif [[ -f /etc/os-release ]]; then
  LINUXBREW_PATH="/home/linuxbrew/.linuxbrew"
  export PATH="$LINUXBREW_PATH/bin:$LINUXBREW_PATH/sbin:${PATH}"

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

export OS_TYPE="linux"
if [[ "$OS" == "macos" ]]; then
  export OS_TYPE="macos"
  export HOMEBREW_CASK_OPTS="--appdir=~/Applications"
fi

# possible modes are: install, uninstall
export MODE="${MODE:-install}"
if [[ "$MODE" == "install" ]]; then
  export STOW_MODE="stow"
elif [[ "$MODE" == "uninstall" ]]; then
  export STOW_MODE="delete"
fi
