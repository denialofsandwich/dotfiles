-- Adds a tab bar at the top
return {
  "akinsho/bufferline.nvim",
  keys = {
    { "<leader>b<Left>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
    { "<leader>b<Right>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
    { "<leader>bn", "<Cmd>BufferLinePick<CR>", desc = "Pick Buffer" },
    { "<leader>bm<Left>", "<Cmd>BufferLineMovePrev<CR>", desc = "Move Buffer Left" },
    { "<leader>bm<Right>", "<Cmd>BufferLineMoveNext<CR>", desc = "Move Buffer Right" },
  },
  opts = {
    options = {
      separator_style = "slant",
    },
  },
}
