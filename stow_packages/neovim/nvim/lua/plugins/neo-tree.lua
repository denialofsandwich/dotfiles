return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_gitignored = true,
          hide_dotfiles = false,
          hide_hidden = false, -- windows
          hide_by_name = {
            ".git",
          },
        },
      },
    },
  },
}
