return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  keys = {
    { "<leader>e", false },
    { "<leader>E", false },
    { "<leader>ge", false },
    { "<leader>be", false },
  },
  opts = {
    filesystem = {
      window = {
        position = "current",
      },
    },
  },
}
