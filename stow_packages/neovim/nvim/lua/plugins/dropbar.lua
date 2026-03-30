-- IDE-like breadcrumbs, out of the box
--  Adds that top bar which shows the current file and symbol
return {
  {
    "Bekaboo/dropbar.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    opts = {
      bar = {
        enable = function(buf, win, _)
          if vim.bo[buf].buftype ~= "" then
            return false
          end
          return true
        end,
        sources = function(buf, win)
          local sources = require("dropbar.sources")
          return { sources.path }
        end,
      },
      sources = {
        path = {
          relative_to = function()
            return vim.fn.getcwd()
          end,
        },
      },
      icons = {
        kinds = {
          dir_icon = "",
        },
      },
    },
  },
}
