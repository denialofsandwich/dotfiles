#!/bin/bash
# Install core tools for my dotfiles

if [[ "$MODE" == "install" ]] && ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ $OS_TYPE == "macos" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
elif [[ "$MODE" == "uninstall" ]]; then
  brew list | xargs brew uninstall -y
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
fi

brew_manage curl jq stow zip git yq jinja2-cli

if [[ "$OS_TYPE" == "macos" ]]; then
  brew_manage coreutils wget
fi

# Steam OS is shipping without build essentials and because it's an immutable OS
# it can't be installed system-wide. This workaround installs them user-wide
# to allow building packages from source.
if [[ "$OS" == "steamos" ]]; then
  brew_manage glibc gcc

  if [[ "$MODE" == "install" ]] && ! command -v brew &>/dev/null; then
    mkdir -p ~/.env_scripts
    cat >~/.env_scripts/gcc_fix.sh <<EOF
export CC="$(brew --prefix gcc)/bin/gcc-15"
export CXX="$(brew --prefix gcc)/bin/g++-15"
EOF
    chmod +x ~/.env_scripts/gcc_fix.sh
  fi
fi

git config --global rerere.enabled true
git config --global pull.rebase true
git config --global rebase.autoStash true
git config --global init.defaultBranch main
