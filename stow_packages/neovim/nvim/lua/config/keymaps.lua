-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Always open the terminal with a unique tmux session,
-- which can survive an exit of nvim,
-- but only if nvim is NOT already running inside a tmux session
local lazyterm = function(use_file_dir)
  local _lazyterm = function()
    local count = vim.v.count1
    local cwd = vim.fn.getcwd()
    local term_cwd = use_file_dir and vim.fn.expand("%:p:h") or cwd
    local dirname = cwd:match(".+/([^/]+)$")
    local position = count >= 10 and "right" or "float"

    local win_config = {
      position = position,
      width = position == "float" and 0.9 or 0.4,
      height = position == "float" and 0.9 or 1.0,
    }

    if vim.env.TMUX == nil then
      local session_name = dirname
        .. "-"
        .. count
        .. "-"
        .. io.popen(
          "echo " .. cwd .. " | openssl dgst -binary -sha1 | openssl base64 -A | tr -dc A-Za-z0-9 | head -c 8"
        )
          :read("*a")

      Snacks.terminal.toggle({
        "tmux",
        "new-session",
        "-A",
        "-s",
        session_name,
      }, { cwd = term_cwd, win = win_config })
    else
      Snacks.terminal.toggle("zsh", { cwd = term_cwd, win = win_config })
    end
  end

  return _lazyterm
end

-- Remap Ctrl-C to Esc to behave exactly like it including autocmd
vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], { desc = "Window navigation" })

vim.keymap.set("n", "<leader>ft", lazyterm(false), { remap = true, desc = "Terminal (Root Dir)" })
vim.keymap.set("n", "<leader>fT", lazyterm(true), { remap = true, desc = "Terminal (File Dir)" })
vim.keymap.set("n", "<C-_>", lazyterm(false), { remap = true, desc = "Terminal (Root Dir)" })
vim.keymap.set("n", "<C-/>", lazyterm(true), { remap = true, desc = "Terminal (File Dir)" })

vim.keymap.set({ "n", "v" }, "<C-Y>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<C-P>", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"0p', { desc = "Paste last yanked line" })

vim.keymap.set("n", "<leader><tab><left>", "<cmd>tabprevious<cr>", { desc = "Vorheriger Tab" })
vim.keymap.set("n", "<leader><tab><right>", "<cmd>tabnext<cr>", { desc = "Nächster Tab" })

vim.keymap.set({ "n" }, "<leader>r", "", { desc = "macro replay" })
vim.keymap.set({ "n" }, "<leader>rq", "@q", { desc = "Replay q-macro" })
vim.keymap.set({ "n" }, "<leader>rw", "@w", { desc = "Replay w-macro" })
vim.keymap.set({ "n" }, "<leader>re", "@e", { desc = "Replay e-macro" })
vim.keymap.set({ "n" }, "<leader>rr", "@r", { desc = "Replay r-macro" })

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

-- In visual mode, select something, then enter "<leader>vf".
-- This enters command mode with ":'<,'>Gfill ".
-- You can then type a prompt and press enter to have Gemini fill the selection.
vim.api.nvim_create_user_command("Gfill", function(opts)
  vim.cmd(
    "'<,'>!gemini -m gemini-2.5-flash-lite '"
      .. opts.args
      .. "; If i provided code: Print the full updated code. Write response without any explanation and follow up questions' 2>/dev/null | sed '1{/^```/d;};${/^```/d;}'"
  )
end, { nargs = "*", range = true, desc = "Fill with Gemini" })

vim.keymap.set("v", "<leader>vf", ":Gfill ", { desc = "Gemini Fill" })
