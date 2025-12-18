-- Autocomplete popup
return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "none",

        ["<Esc>"] = { "hide", "fallback" },
        ["<C-c>"] = { "hide", "fallback" },
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
