return {
  {
    "rcarriga/nvim-notify",
    opts = {
      top_down = false,
    },
  },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.presets = {
        -- I wanted to have the command input more in the middle
        command_palette = {
          views = {
            cmdline_popup = {
              position = {
                row = "30%",
                col = "50%",
              },
              size = {
                min_width = 60,
                width = "auto",
                height = "auto",
              },
            },
            cmdline_popupmenu = {
              position = {
                row = "47%",
                col = "50%",
              },
            },
          },
        },
      }
      opts.lsp.signature = {
        opts = { size = { max_height = 15 } },
      }
    end,
  },
}
