vim.pack.add { "https://github.com/mfussenegger/nvim-dap" }
vim.pack.add { "https://github.com/igorlfs/nvim-dap-view" }
vim.pack.add { "https://github.com/leoluz/nvim-dap-go" }
vim.pack.add { "https://github.com/mfussenegger/nvim-dap-python" }

local initialized = false
local function setup()
  if initialized then return end
  initialized = true
  require("dap-view").setup {}
  require("dap-go").setup {}
  require("dap-python").setup "uv"
end

local km = vim.keymap
km.set("n", "<leader>db", function() setup(); vim.cmd "DapToggleBreakpoint" end)
km.set("n", "<leader>dc", function() setup(); vim.cmd "DapContinue" end)
km.set("n", "<leader>dgo", function() setup(); vim.cmd "DapStepOver" end)
km.set("n", "<leader>dgi", function() setup(); vim.cmd "DapStepInto" end)
km.set("n", "<leader>du", function() setup(); vim.cmd "DapViewToggle" end)
km.set("n", "<leader>dpt", function() setup(); require("dap-python").test_method() end)
km.set("n", "<leader>dpc", function() setup(); require("dap-python").test_class() end)
km.set("n", "<leader>dps", function() setup(); require("dap-python").debug_selection() end)
