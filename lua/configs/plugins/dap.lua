vim.pack.add { "https://github.com/mfussenegger/nvim-dap" }
vim.pack.add { "https://github.com/igorlfs/nvim-dap-view" }

local km = vim.keymap

km.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>")
km.set("n", "<leader>dc", "<cmd>DapContinue<cr>")
km.set("n", "<leader>dgo", "<cmd>DapStepOver<cr>")
km.set("n", "<leader>dgi", "<cmd>DapStepInto<cr>")

require("dap-view").setup {}
km.set("n", "<leader>du", "<cmd>DapViewToggle<cr>")

-- Language specific
-- GO
vim.pack.add { "https://github.com/leoluz/nvim-dap-go" }
require("dap-go").setup {}

-- Python
vim.pack.add { "https://github.com/mfussenegger/nvim-dap-python" }
require("dap-python").setup "uv"

km.set("n", "<leader>dpt", "<cmd>lua require('dap-python').test_method()<cr>")
km.set("n", "<leader>dpc", "<cmd>lua require('dap-python').test_class()<cr>")
km.set("n", "<leader>dps", "<cmd>lua require('dap-python').debug_selection()<cr>")
