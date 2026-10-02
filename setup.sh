#!/bin/bash

set -euo pipefail
pushd "$(dirname "$0")" || exit 1

source default_vars.sh
if [[ -f custom_vars.sh ]]; then
  source custom_vars.sh
fi

if [[ "$OS" == "unknown" ]]; then
  echo "Error: Unsupported OS"
  exit 1
fi

# Modules to install
export MODULES=${MODULES:-${DEVC_MODULES:-$DEFAULT_MODULES}}
# Used for modules that need to be configured without actually installing them
#   eg. modules only available in devc
export MODULES_REQUESTED="$MODULES_REQUESTED $DEFAULT_MODULES"

if [[ "$MODE" == "uninstall" ]]; then
  # Revert order on uninstall
  export MODULES=$(echo "$MODULES" | tr ' ' '\n' | tac | paste -sd ' ' -)
fi

for module in $MODULES; do
  (
    set -euo pipefail
    echo -e "${YELLOW}### SETUP ${module}${NC}"
    export MODULE=$module
    source "./setup_scripts/_utils.sh"
    source "./setup_scripts/${module}.sh"
  )
done

popd || exit 1
