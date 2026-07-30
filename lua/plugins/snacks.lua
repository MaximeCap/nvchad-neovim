return {
  "folke/snacks.nvim",
  opts = {
    input = { enabled = true },
    picker = {
      enabled = true,
      layout = "select",
      sources = {
        files = { hidden = true },
        grep = { hidden = true },
        explorer = { hidden = true },
      },
    },
    bigfile = { enabled = true }, -- désactive treesitter/LSP sur les gros fichiers
    notifier = { enabled = true }, -- remplace vim.notify
    words = { enabled = true }, -- surligne les références LSP sous le curseur
    indent = { enabled = true },
    scope = { enabled = true },
  },
  keys = {
    {
      "<leader>un",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification history",
    },
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
