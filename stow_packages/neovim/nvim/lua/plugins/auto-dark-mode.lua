return {
  "f-person/auto-dark-mode.nvim",
  lazy = false,
  priority = 1000,
  config = function(_, opts)
    if vim.env.NEOVIM_FORCE_DARK_THEME == "yes" then
      vim.o.background = "dark"
      return
    end
    require("auto-dark-mode").setup(opts)
  end,
}
