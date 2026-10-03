#!/bin/bash
# Setup claude code cli

# Before the install, so it doesn't conflict with a generated settings.json.
stow_manage_simple ~/.claude

curl -fsSL https://claude.ai/install.sh | bash
