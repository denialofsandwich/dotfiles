#!/bin/bash
# Setup Python and its ecosystem, including uv, ipython, and poetry.

brew_manage uv

uv tool install ipython
uv tool install pre-commit
uv tool install poetry
