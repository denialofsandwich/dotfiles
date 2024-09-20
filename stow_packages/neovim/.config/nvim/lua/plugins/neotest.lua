return {
  {
    "andythigpen/nvim-coverage",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      auto_reload = true,
    },
    keys = {
      { "<leader>tc", "", desc = "+coverage" },
      {
        "<leader>tcc",
        function()
          require("coverage").load(true)
        end,
        desc = "Show Coverage",
      },
      {
        "<leader>tcr",
        function()
          require("coverage").clear()
        end,
        desc = "Hide Coverage",
      },
      {
        "<leader>tcs",
        function()
          require("coverage").summary()
        end,
        desc = "Show Coverage Summary Popup",
      },
    },
  },
}
