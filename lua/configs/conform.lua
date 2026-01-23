local options = {
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

return options
