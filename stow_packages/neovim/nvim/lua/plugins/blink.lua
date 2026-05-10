-- Autocomplete popup
local function exit_and_hide(cmp)
  if cmp.is_menu_visible() then
    cmp.hide()
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
  return true
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
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
      },
    },
  },
}
