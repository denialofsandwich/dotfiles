-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Show relativenumbers only if it's really needed
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  pattern = "*",
  callback = function(args)
    if vim.wo.number and vim.fn.mode() ~= "i" then
      vim.wo.relativenumber = true
      vim.cmd([[ redraw ]])
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  pattern = "*",
  callback = function(args)
    if vim.wo.number then
      vim.wo.relativenumber = false
      vim.cmd([[ redraw ]])
    end
  end,
})
