-- IDE-like breadcrumbs, out of the box
--  Adds that top bar which shows the current file and symbol
return {
  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    config = true,
  },
}
