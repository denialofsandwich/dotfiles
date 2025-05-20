-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Always open the terminal with a unique tmux session,
-- which can survive an exit of nvim,
-- but only if nvim is NOT already running inside a tmux session
local lazyterm = function()
  local count = vim.v.count1
  local cwd = vim.fn.getcwd()
  local dirname = cwd:match(".+/([^/]+)$")

  if vim.env.TMUX == nil then
    Snacks.terminal.toggle({
      "bash",
      "-c",
      "tmux new-session -A -s "
        .. dirname
        .. "-"
        .. count
        .. "-$(echo "
        .. cwd
        .. " | openssl dgst -binary -sha1 | openssl base64 -A | tr -dc A-Za-z0-9 | head -c 8)",
    }, { cwd = cwd, win = { position = "right", height = 0.5, width = 0.5 } })
  else
    Snacks.terminal.toggle("zsh", { cwd = cwd, win = { position = "right", height = 0.5, width = 0.5 } })
  end
end

-- Remap Ctrl-C to Esc to behave exactly like it including autocmd
vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>ft", lazyterm, { remap = true, desc = "Terminal (Root Dir)" })
vim.keymap.set("n", "<C-/>", lazyterm, { remap = true, desc = "Terminal (Root Dir)" })
vim.keymap.set("n", "<C-_>", lazyterm, { remap = true, desc = "Terminal (Root Dir)" })

vim.keymap.set({ "n", "v" }, "<C-Y>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<C-P>", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"0p', { desc = "Paste last yanked line" })

vim.keymap.set({ "n" }, "<leader>r", "", { desc = "macro replay" })
vim.keymap.set({ "n" }, "<leader>rq", "@q", { desc = "Replay q-macro" })
vim.keymap.set({ "n" }, "<leader>rw", "@w", { desc = "Replay w-macro" })
vim.keymap.set({ "n" }, "<leader>re", "@e", { desc = "Replay e-macro" })
vim.keymap.set({ "n" }, "<leader>rr", "@r", { desc = "Replay r-macro" })
