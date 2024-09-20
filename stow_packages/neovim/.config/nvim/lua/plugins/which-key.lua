return {
  {
    "folke/which-key.nvim",
    opts = {
      defer = function(ctx)
        return ctx.mode == "V" or ctx.mode == "<C-V>" or ctx.mode == "v"
      end,
    },
  },
}
