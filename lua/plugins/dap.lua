local ensure = require("config.lazy").loader({
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/igorlfs/nvim-dap-view",
  "https://github.com/leoluz/nvim-dap-go",
  "https://github.com/mfussenegger/nvim-dap-python",
}, function()
  require("dap-view").setup {}
  require("dap-go").setup {}
  require("dap-python").setup "uv"
end)

local km = vim.keymap
km.set("n", "<leader>db", function() ensure(); vim.cmd "DapToggleBreakpoint" end)
km.set("n", "<leader>dc", function() ensure(); vim.cmd "DapContinue" end)
km.set("n", "<leader>dgo", function() ensure(); vim.cmd "DapStepOver" end)
km.set("n", "<leader>dgi", function() ensure(); vim.cmd "DapStepInto" end)
km.set("n", "<leader>du", function() ensure(); vim.cmd "DapViewToggle" end)
km.set("n", "<leader>dpt", function() ensure(); require("dap-python").test_method() end)
km.set("n", "<leader>dpc", function() ensure(); require("dap-python").test_class() end)
km.set("n", "<leader>dps", function() ensure(); require("dap-python").debug_selection() end)
