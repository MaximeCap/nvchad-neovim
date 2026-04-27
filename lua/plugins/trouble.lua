vim.pack.add { "https://github.com/folke/trouble.nvim" }

require("trouble").setup {}

local map = vim.keymap.set

map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
map(
  "n",
  "<leader>xr",
  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  { desc = "LSP Refs/Defs/Impls (Trouble)" }
)
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
