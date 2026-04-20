-- Lsp configuration
vim.pack.add { "https://github.com/mason-org/mason.nvim" }
vim.pack.add { "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" }
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
  -- Lint
  "eslint",
  -- Formatter
  "biome",
  "stylua",
  "ruff",
  "prettier",
  "goimports",
  -- dap
  "delve",
  "debugpy",
}

require("mason").setup {}
require("mason-lspconfig").setup {
  automatic_enable = true,
}
require("mason-tool-installer").setup {
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

-- Advertise blink.cmp's richer completion capabilities to every LSP server
-- (without this, servers don't know to send e.g. snippet/additionalTextEdits)
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink then
  vim.lsp.config("*", { capabilities = blink.get_lsp_capabilities() })
end

-- Activate LSP servers
-- vim.lsp.enable(servers)
-- Activate inlay hint
vim.lsp.inlay_hint.enable()

vim.diagnostic.config {
  severity_sort = true, -- sort by severity so errors render on top of warnings etc.
  update_in_insert = true,
  underline = true,
  float = {
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticError",
      [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticHint",
    },
  },
  virtual_text = {
    spacing = 2,
    source = "if_many",
    prefix = "●",
  },
}
