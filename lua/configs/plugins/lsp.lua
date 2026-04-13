-- Lsp configuration
vim.pack.add { "https://github.com/mason-org/mason.nvim" }
vim.pack.add { "https://github.com/mason-org/mason-lspconfig.nvim" }
vim.pack.add { "https://github.com/neovim/nvim-lspconfig" }
vim.pack.add { "https://github.com/j-hui/fidget.nvim" }

require("fidget").setup {}

local servers = {
  -- Language
  "lua_ls",
  "gopls",
  "ts_ls",
  "tailwindcss",
  "basedpyright",
  -- Formatter
  "biome",
  "stylua",
  "ruff",
}

require("mason").setup {}
require("mason-lspconfig").setup {
  ensure_installed = servers,
}

-- local servers = {
--   "html",
--   "cssls",
--   "rust_analyzer",
--   "delve",
--   "biome",
--   "vtsls",
--   "gopls",
--   "eslint",
--   "basedpyright",
--   "ruff",
--   "lua_ls",
--   "debugpy",
--   "tailwindcss",
--   "yamlls",
--   "dockerls",
--   "marksman",
-- }

-- Activate LSP servers
vim.lsp.enable(servers)
-- Activate inlay hint
vim.lsp.inlay_hint.enable()
-- Setup diagnostic to be writtenb even on insert mode
vim.diagnostic.config {
  update_in_insert = true,
  underline = true,
  virtual_text = {
    spacing = 2,
    source = "if_many",
    prefix = "●",
  },
}
