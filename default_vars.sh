export DEFAULT_MODULES="core bash nerd-font oh-my-posh zsh screen tmux vim python neovim lazygit misc yazi btop kitty"
# If yes, it explicitly sets the kitty and tmux shell to zsh
export FORCE_ZSH=yes

export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export NC='\033[0m'

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

# possible modes are: install, uninstall
export MODE="${MODE:-install}"
[[ "$MODE" == "install" ]] && export STOW_MODE="stow"
[[ "$MODE" == "uninstall" ]] && export STOW_MODE="delete"

export OS_TYPE="linux"
if [[ "$OS" == "macos" ]]; then
  export OS_TYPE="macos"
  export HOMEBREW_CASK_OPTS="--appdir=~/Applications"
fi
