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
    Snacks.terminal.open({
      "bash",
      "-c",
      "tmux new-session -A -s "
        .. dirname
        .. "-"
        .. count
        .. "-$(echo "
        .. cwd
        .. " | openssl dgst -binary -sha1 | openssl base64 -A | tr -dc A-Za-z0-9 | head -c 8)",
    }, { cwd = cwd })
  else
    Snacks.terminal.open({ cwd = cwd })
  end
end

vim.keymap.set("n", "<leader>ft", lazyterm, { remap = true, desc = "Terminal (Root Dir)" })
vim.keymap.set("n", "<C-/>", lazyterm, { remap = true, desc = "Terminal (Root Dir)" })
vim.keymap.set("n", "<C-_>", lazyterm, { remap = true, desc = "Terminal (Root Dir)" })

vim.keymap.set({ "n", "v" }, "<C-Y>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<C-P>", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"0p', { desc = "Paste last yanked line" })

vim.keymap.set({ "n" }, "<leader>r", "@q", { desc = "Replay q-macro " })
