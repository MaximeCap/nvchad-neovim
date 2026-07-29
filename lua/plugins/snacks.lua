return {
  "folke/snacks.nvim",
  opts = {
    input = { enabled = true },
    picker = { enabled = true, layout = "select" },
  },
  keys = {
    {
      "<leader><leader>",
      function()
        Snacks.picker.files()
      end,
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep()
      end,
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
    },

    {
      "<leader>fs",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "LSP Symbols",
    },
    {
      "<leader>fw",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
    },
    {
      "<leader>su",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo History",
    },
  },
}
