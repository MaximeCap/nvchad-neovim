-- DAP — débogage.
--
-- Les adapters (delve pour Go, debugpy pour Python) sont installés par
-- mason-tool-installer (voir `tools` dans plugins/lsp.lua).
--
-- Chargement paresseux via `keys` : nvim-dap (et ses extensions) ne se chargent
-- qu'au premier <leader>d… — lazy lance alors `config` puis exécute la touche.
-- C'est l'équivalent natif du pattern `ensure()` de l'ancienne config vim.pack.
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "igorlfs/nvim-dap-view",
    "leoluz/nvim-dap-go",
    "mfussenegger/nvim-dap-python",
  },
  keys = {
    { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint" },
    { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
    { "<leader>dgo", "<cmd>DapStepOver<cr>", desc = "Step over" },
    { "<leader>dgi", "<cmd>DapStepInto<cr>", desc = "Step into" },
    { "<leader>du", "<cmd>DapViewToggle<cr>", desc = "Toggle DapView" },
    { "<leader>dpt", function() require("dap-python").test_method() end, desc = "Python Test method" },
    { "<leader>dpc", function() require("dap-python").test_class() end, desc = "Python Test class" },
    { "<leader>dps", function() require("dap-python").debug_selection() end, mode = "v", desc = "Python Test selection" },
  },
  config = function()
    require("dap-view").setup {}
    require("dap-go").setup {
      dap_configurations = {
        {
          type = "go",
          name = "Attach remote",
          mode = "remote",
          request = "attach",
          host = "127.0.0.1",
          port = 38697,
        },
      },
    }
    require("dap-python").setup "uv"
  end,
}
