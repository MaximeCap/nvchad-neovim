-- Formatting — conform.nvim.
--
-- Les binaires (stylua, biome, prettier/prettierd, goimports, gofumpt, ruff,
-- sqlfmt, pgformatter) sont installés par mason-tool-installer (voir `tools`
-- dans plugins/lsp.lua).
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- chargé à temps pour le format-on-save
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>fm",
      function()
        require("conform").format { async = false, timeout_ms = 1200 }
      end,
      mode = { "n", "v" }, -- `v` → range formatting sur la sélection
      desc = "Format buffer / selection",
    },
  },
  opts = {
    -- Options par défaut appliquées partout (keymap + on-save), sans répéter.
    -- "fallback" = formate via le LSP si aucun formatter externe n'existe.
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      css = { "biome", "prettier", stop_after_first = true },
      html = { "biome", "prettier", stop_after_first = true },
      go = { "goimports", "gofumpt" }, -- les deux : goimports gère les imports, gofumpt le style
      javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
      typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
      python = { "ruff" },
      sql = { "sqlfmt", "pgformatter", stop_after_first = true },
    },
    -- format_on_save hérite de default_format_opts ; on n'ajoute que le timeout.
    format_on_save = {
      timeout_ms = 1200,
    },
  },
}
