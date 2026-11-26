-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Always open the terminal with a unique tmux session,
-- which can survive an exit of nvim,
-- but only if nvim is NOT already running inside a tmux session
local lazyterm = function(use_file_dir)
  local _lazyterm = function()
    Snacks.terminal.toggle("zsh", {
      cwd = use_file_dir and vim.fn.expand("%:p:h") or vim.fn.getcwd(),
      win = {
        position = "right",
        width = 0.4,
        height = 1.0,
      },
    })
  end

  return _lazyterm
end

-- Remap Ctrl-C to Esc to behave exactly like it including autocmd
vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>ft", lazyterm(false), { desc = "Terminal (Root Dir)" })
vim.keymap.set("n", "<leader>fT", lazyterm(true), { desc = "Terminal (File Dir)" })
vim.keymap.set({ "n", "t" }, "<C-_>", lazyterm(false), { desc = "Terminal (Root Dir)" })
vim.keymap.set({ "n", "t" }, "<C-/>", lazyterm(true), { desc = "Terminal (File Dir)" })
-- Allows navigating windows within the terminal without leaving terminal mode
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], { desc = "Window navigation" })

-- Ignore stray modifier key sent by remapped keyboard
vim.keymap.set({ "n", "i", "v", "x", "s", "o", "c", "t" }, "<D-F18>", "<Nop>", { desc = "Ignore remapped keyboard modifier" })

-- Delete word on Ctrl+Backspace and Alt+Backspace
vim.keymap.set({ "i", "c" }, "<C-BS>", "<C-w>", { desc = "Delete word backward" })
vim.keymap.set({ "i", "c" }, "<M-BS>", "<C-w>", { desc = "Delete word backward" })
vim.keymap.set("n", "<C-BS>", "db", { desc = "Delete word backward" })
vim.keymap.set("n", "<M-BS>", "db", { desc = "Delete word backward" })

-- Jump word on Ctrl/Alt + Left/Right
vim.keymap.set({ "n", "v" }, "<C-Left>", "b", { desc = "Jump word backward" })
vim.keymap.set({ "n", "v" }, "<C-Right>", "w", { desc = "Jump word forward" })
vim.keymap.set({ "n", "v" }, "<M-Left>", "b", { desc = "Jump word backward" })
vim.keymap.set({ "n", "v" }, "<M-Right>", "w", { desc = "Jump word forward" })
vim.keymap.set({ "i", "c" }, "<C-Left>", "<S-Left>", { desc = "Jump word backward" })
vim.keymap.set({ "i", "c" }, "<C-Right>", "<S-Right>", { desc = "Jump word forward" })
vim.keymap.set({ "i", "c" }, "<M-Left>", "<S-Left>", { desc = "Jump word backward" })
vim.keymap.set({ "i", "c" }, "<M-Right>", "<S-Right>", { desc = "Jump word forward" })

-- Remap [ and ] for german keyboards
vim.keymap.set({ "n", "x", "o" }, "ö", "[", { remap = true, desc = "Alias for [" })
vim.keymap.set({ "n", "x", "o" }, "ä", "]", { remap = true, desc = "Alias for ]" })

vim.keymap.set({ "n", "v" }, "<C-Y>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<C-P>", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"0p', { desc = "Paste last yanked line" })
vim.keymap.set("v", "/", 'y/<C-R>"<CR>', { desc = "Yank and search selection" })

vim.keymap.set("n", "<leader><tab><left>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader><tab><right>", "<cmd>tabnext<cr>", { desc = "Next tab" })

vim.keymap.set({ "n" }, "<leader>v", "", { desc = "custom stuff" })

vim.keymap.set("n", "<leader>vy", function()
  local file_path = vim.fn.expand("%:p")
  local project_root = vim.fn.getcwd()
  local relative_path = file_path:gsub(project_root .. "/", "")
  vim.fn.setreg("+", relative_path .. ":" .. vim.fn.line("."))
end, { desc = "Copy filename and line number" })

vim.keymap.set("v", "<leader>vy", function()
  local file_path = vim.fn.expand("%:p")
  local project_root = vim.fn.getcwd()
  local relative_path = file_path:gsub(project_root .. "/", "")
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  vim.fn.setreg("+", relative_path .. ":" .. start_line .. "-" .. end_line)
  vim.api.nvim_input("<Esc>")
end, { desc = "Copy filename and line range" })
