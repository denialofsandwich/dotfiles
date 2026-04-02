#!/bin/bash

set -euo pipefail
pushd "$(dirname "$0")" || exit 1

git config --global rerere.enabled true
git config --global pull.rebase true

DEFAULT_MODULES="
  core,
  bash,
  fzf,
  nerd-font,
  oh-my-posh,
  zsh,
  xonsh,
  python,
  screen,
  tmux,
  vim,
  lazygit,
  nvm,
  neovim,
  yazi,
  kitty,
  dysk,
  gemini-cli
"
MODULES=${MODULES:-$(echo "$DEFAULT_MODULES" | tr -d '[:space:]')}
# possible modes are: stow, delete, restow
export MODE="${MODE:-stow}"

for script in ${MODULES//,/ }; do
  bash "./setup_scripts/${script}.sh"
done

popd || exit 1
