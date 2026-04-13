-- Mini configuration
vim.pack.add { "https://github.com/nvim-mini/mini.nvim" }
require("mini.pairs").setup {}
require("mini.pick").setup {}
vim.keymap.set("n", "<leader><leader>", "<cmd>Pick files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Pick grep_live<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Pick buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Pick help<cr>")

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

-- Conform configuration
vim.pack.add { "https://github.com/stevearc/conform.nvim" }

require("conform").setup {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    go = { "goimport" },
    javascript = { "prettierd", "prettier", "biome", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", "biome", stop_after_first = true },
    typescript = { "prettierd", "prettier", "biome", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", "biome", stop_after_first = true },
    python = { "ruff" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1200,
    lsp_fallback = true,
  },
}

-- LSP Plugin configuration
require "configs.plugins.lsp"
