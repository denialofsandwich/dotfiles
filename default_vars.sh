DEFAULT_MODULES="core bash nerd-font oh-my-posh zsh screen tmux vim python neovim lazygit yazi btop kitty"
FORCE_ZSH=yes

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
