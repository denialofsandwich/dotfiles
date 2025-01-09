-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LSP Server to use for Python.
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"

vim.g.python3_host_prog = "~/.pyenv/versions/pynvim/bin/python"
vim.g.python_host_prog = "~/.pyenv/versions/pynvim/bin/python"

vim.opt.relativenumber = true
vim.opt.shell = "/bin/zsh"
vim.opt.wrap = true
vim.opt.spell = true
vim.opt.clipboard = ""
vim.opt.formatoptions:remove({ "r", "o" })
vim.opt.conceallevel = 0
