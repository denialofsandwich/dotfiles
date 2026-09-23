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

MODULES=${MODULES:-$DEFAULT_MODULES}

if [[ "$MODE" == "uninstall" ]]; then
  # Revert order on uninstall
  MODULES=$(echo "$MODULES" | tr ' ' '\n' | tac | paste -sd ' ' -)
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
