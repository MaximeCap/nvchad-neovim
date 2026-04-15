-- Fzf-lua
vim.pack.add { "https://github.com/ibhagwan/fzf-lua" }
require("fzf-lua").setup {
  ui_select = true,
}

vim.keymap.set("n", "<leader><leader>", "<cmd>FzfLua files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua grep_visual<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua helptags<cr>")

-- Mini configuration
vim.pack.add { "https://github.com/nvim-mini/mini.nvim" }
require("mini.pairs").setup {}
require("mini.icons").setup {}

require("mini.git").setup {}
require("mini.diff").setup {
  view = {
    style = "number",
  },
}

-- Oil configuration
vim.pack.add { "https://github.com/stevearc/oil.nvim" }

require("oil").setup {
  win_options = {
    signcolumn = "yes:1",
  },
  view_options = {
    show_hidden = true,
  },
}

vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>")

-- Completion configuration
require "configs.plugins.completion"

-- Conform configuration
require "configs.plugins.conform"

-- LSP Plugin configuration
require "configs.plugins.lsp"

-- Lazydev
require "configs.plugins.lazydev"

-- Treesitter Manager
require "configs.plugins.treesitter"

-- Obsidian
require "configs.plugins.obsidian"
