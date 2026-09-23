#!/bin/bash
# Setup Python and its ecosystem, including uv, ipython, and poetry.

brew "$MODE" -y uv

type ipython || uv tool install ipython
type pre-commit || uv tool install pre-commit
type poetry || uv tool install poetry
