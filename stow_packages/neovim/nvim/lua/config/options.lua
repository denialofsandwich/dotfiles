-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.python3_host_prog = "~/.local/nvim/venv/bin/python"
vim.g.python_host_prog = "~/.local/nvim/venv/bin/python"

vim.opt.clipboard = ""
vim.opt.shell = "/bin/zsh"
vim.opt.wrap = true
vim.opt.spell = true
vim.opt.title = true
vim.g.root_spec = { "cwd" }
vim.g.mapleader = " "
vim.g.maplocalleader = "ö"
