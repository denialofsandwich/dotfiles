#!/bin/bash
# Install core tools for my dotfiles

if [[ "$MODE" == "install" ]] && ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ $OS_TYPE == "linux" && "$MODE" == "uninstall" ]]; then
  sudo rm -rf /home/linuxbrew
fi

if [[ $ROOT_PACKAGES == "yes" && $OS_TYPE == "linux" ]]; then
  sudo $LINUX_PKG_MGR install -y \
    htop lsof curl jq git vim screen tmux bash zsh btop croc
fi

brew "$MODE" htop lsof curl jq stow zip git btop croc

if [[ $OS_TYPE == "macos" ]]; then
  brew "$MODE" telnet
elif [[ $OS == "steamos" ]]; then
  brew "$MODE" glibc gcc
  mkdir -p ~/.env_scripts
  cat >~/.env_scripts/gcc_fix.sh <<EOF
export CC="$(brew --prefix gcc)/bin/gcc-15"
export CXX="$(brew --prefix gcc)/bin/g++-15"
EOF
  chmod +x ~/.env_scripts/gcc_fix.sh
fi

git config --global rerere.enabled true
git config --global pull.rebase true
