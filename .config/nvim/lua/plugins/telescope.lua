local Util = require("lazyvim.util")

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>,", false },
    { "<leader>fF", false },
    { "<leader>fr", false },
    { "<leader>fR", false },
    { "<leader>sa", false },
    { "<leader>sc", false },
    { "<leader>sH", false },
    { "<leader>sR", false },
    { "<leader>uC", false },
    { "<leader>ss", false },
    { "<leader>sS", false },

    { "<leader><space>", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
    { "<leader>*", "<cmd>Telescope grep_string<cr>", { silent = true, desc = "Grep Word Under Cursor" } },
    { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy Search in Current Buffer" },
    { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume Search" },

    {
      "<leader>gs",
      function()
        require("telescope.builtin").lsp_document_symbols({
          symbols = require("lazyvim.config").get_kind_filter(),
        })
      end,
      desc = "Goto Symbol",
    },
    {
      "<leader>gS",
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols({
          symbols = require("lazyvim.config").get_kind_filter(),
        })
      end,
      desc = "Goto Symbol (Workspace)",
    },
  },
  opts = function(_, opts)
    opts.defaults.path_display = { "smart" }
  end,
}
