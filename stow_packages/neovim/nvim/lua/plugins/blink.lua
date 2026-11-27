local function exit_and_hide(cmp)
  if cmp.is_menu_visible() then
    cmp.hide()
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
  return true
end

local kitty_source = {}
kitty_source.__index = kitty_source

local kitty_cache = {
  timestamp = 0,
  items = {},
}

function kitty_source.new(opts)
  return setmetatable({ opts = opts or {} }, kitty_source)
end

function kitty_source:enabled()
  return vim.env.KITTY_WINDOW_ID ~= nil
end

function kitty_source:get_completions(_, callback)
  local now = vim.uv.now()
  local ttl = self.opts.cache_ttl or 2000

  if now - kitty_cache.timestamp < ttl then
    callback({
      items = kitty_cache.items,
      is_incomplete_forward = false,
      is_incomplete_backward = false,
    })
    return
  end

  local extent = self.opts.extent or "screen" -- "screen" (only visible content) or "all" (including scrollback)
  local min_len = self.opts.min_word_length or 3
  local self_id = tonumber(vim.env.KITTY_WINDOW_ID)

  vim.system({ "kitten", "@", "ls" }, { text = true }, function(ls_res)
    if ls_res.code ~= 0 or not ls_res.stdout then
      vim.schedule(function()
        callback({ items = {} })
      end)
      return
    end

    local ok, os_windows = pcall(vim.json.decode, ls_res.stdout)
    if not ok or type(os_windows) ~= "table" then
      vim.schedule(function()
        callback({ items = {} })
      end)
      return
    end

    local win_ids = {}
    for _, os_win in ipairs(os_windows) do
      for _, tab in ipairs(os_win.tabs or {}) do
        for _, win in ipairs(tab.windows or {}) do
          if not win.is_self and win.id ~= self_id then
            table.insert(win_ids, win.id)
          end
        end
      end
    end

    if #win_ids == 0 then
      vim.schedule(function()
        kitty_cache = { timestamp = vim.uv.now(), items = {} }
        callback({ items = {} })
      end)
      return
    end

    local words = {}
    local pending = #win_ids

    for _, id in ipairs(win_ids) do
      vim.system(
        { "kitten", "@", "get-text", "--match", "id:" .. id, "--extent", extent },
        { text = true },
        function(txt_res)
          if txt_res.code == 0 and txt_res.stdout then
            for word in txt_res.stdout:gmatch("[%w_]+") do
              if #word >= min_len then
                words[word] = true
              end
            end
          end

          pending = pending - 1
          if pending == 0 then
            vim.schedule(function()
              local kind = require("blink.cmp.types").CompletionItemKind.Text
              local items = {}
              for word in pairs(words) do
                table.insert(items, {
                  label = word,
                  label_description = "kitty",
                  kind = kind,
                })
              end

              kitty_cache = { timestamp = vim.uv.now(), items = items }
              callback({
                items = items,
                is_incomplete_forward = false,
                is_incomplete_backward = false,
              })
            end)
          end
        end
      )
    end
  end)
end

package.preload["blink_kitty"] = function()
  return kitty_source
end

return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "none",

        ["<Esc>"] = { exit_and_hide },
        ["<C-c>"] = { exit_and_hide },
        ["<C-v>"] = { "show", "select_next" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },

        ["<PageUp>"] = {
          function(cmp)
            if cmp.is_menu_visible() then
              cmp.select_prev({ count = 7 })
              return true
            end
          end,
          "fallback",
        },
        ["<PageDown>"] = {
          function(cmp)
            if cmp.is_menu_visible() then
              cmp.select_next({ count = 7 })
              return true
            end
          end,
          "fallback",
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer", "kitty" },
        providers = {
          buffer = {
            opts = {
              get_bufnrs = function()
                return vim
                  .iter(vim.api.nvim_list_wins())
                  :map(function(win)
                    return vim.api.nvim_win_get_buf(win)
                  end)
                  :totable()
              end,
            },
          },
          kitty = {
            name = "Kitty",
            module = "blink_kitty",
            score_offset = -5,
            opts = {
              extent = "screen",
              min_word_length = 3,
              cache_ttl = 2000,
            },
          },
        },
      },

      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
        menu = {
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" }, { "source_name" } },
            components = {
              source_name = {
                highlight = "Comment",
              },
            },
          },
        },
      },
    },
  },
}
