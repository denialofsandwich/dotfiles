#!/bin/bash
# Install core tools for my dotfiles

if [[ "$MODE" == "install" ]] && ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ "$MODE" == "uninstall" && "$OS_TYPE" == "linux" ]]; then
  # Uninstall works slightly differently and requires root on macos
  brew list | xargs brew uninstall -y
  rm -rf /home/linuxbrew
fi

# If some packages need to be globally available on linux
if [[ "$ROOT_PACKAGES" == "yes" && "$OS_TYPE" == "linux" ]]; then
  sudo "$LINUX_PKG_MGR" install -y \
    htop lsof curl jq git vim screen tmux bash zsh croc
fi

brew "$MODE" -y htop lsof curl jq stow zip git croc lazysql yq jinja2-cli fastfetch

# OS specific packages
if [[ "$OS_TYPE" == "linux" ]]; then
  brew "$MODE" -y dysk
elif [[ "$OS_TYPE" == "macos" ]]; then
  brew "$MODE" -y telnet coreutils wget
fi

# Steam OS is shipping without build essentials and because it's an immutable OS
# It can't be installed system-wide. This workaround installs them user-wide
# to allow building packages from source.
if [[ "$OS" == "steamos" ]]; then
  brew "$MODE" -y glibc gcc
  mkdir -p ~/.env_scripts
  cat >~/.env_scripts/gcc_fix.sh <<EOF
export CC="$(brew --prefix gcc)/bin/gcc-15"
export CXX="$(brew --prefix gcc)/bin/g++-15"
EOF
  chmod +x ~/.env_scripts/gcc_fix.sh
fi

git config --global rerere.enabled true
git config --global pull.rebase true
git config --global rebase.autoStash true
git config --global init.defaultBranch main
