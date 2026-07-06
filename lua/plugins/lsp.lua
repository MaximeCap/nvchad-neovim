-- LSP — setup natif Neovim 0.11/0.12.
--
-- Découpage des responsabilités :
--   * mason.nvim           → télécharge/installe les binaires (LSP, formatters, linters, DAP)
--   * mason-tool-installer → garde tout le toolchain installé de façon déclarative
--   * mason-lspconfig      → auto-active les serveurs installés via vim.lsp.enable()
--   * nvim-lspconfig       → fournit les `lsp/<serveur>.lua` par défaut
--   * fidget.nvim          → UI de progression LSP
--
-- Pour configurer un serveur précis, crée un fichier
-- `~/.config/nvim/lsp/<serveur>.lua` qui renvoie une table (API native) — voir
-- la note en bas de fichier. Les capabilities globales sont posées ici ; le
-- style des diagnostics vit dans `config/options.lua`.

-- Toolchain que mason garde installé.
--   - Les LSP sont auto-activés par mason-lspconfig (automatic_enable).
--   - Les linters / formatters / DAP sont juste installés (utilisés par
--     conform / lint / dap ailleurs dans ta config).
local tools = {
  -- LSP servers
  "lua_ls",
  "gopls",
  "vtsls",
  "tailwindcss",
  "basedpyright",
  "docker_language_server",
  "yamlls",
  "jsonls",
  -- Linters
  "eslint",
  "sqlfluff",
  -- Formatters
  "biome",
  "stylua",
  "ruff",
  "prettier",
  "prettierd",
  "goimports",
  "gofumpt",
  "sqlfmt",
  "pgformatter",
  -- DAP
  "delve",
  "debugpy",
}

return {
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
      { "WhoIsSethDaniel/mason-tool-installer.nvim", opts = { ensure_installed = tools } },
      { "j-hui/fidget.nvim", opts = {} },
      -- Catalogue de schémas JSON/YAML (schemastore.org) consommé par
      -- lsp/jsonls.lua et lsp/yamlls.lua pour l'auto-association des schémas.
      "b0o/SchemaStore.nvim",
    },
    -- automatic_enable = true est le défaut : mason-lspconfig appelle
    -- vim.lsp.enable() pour chaque serveur installé. On le laisse explicite.
    opts = {
      automatic_enable = true,
    },
    config = function(_, opts)
      -- Annonce les capabilities enrichies de blink.cmp à TOUS les serveurs.
      -- À faire avant le setup() pour que l'auto-enable en hérite.
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      require("mason-lspconfig").setup(opts)

      -- Inlay hints actifs partout (note l'argument `true` — sans lui ça désactive).
      vim.lsp.inlay_hint.enable(true)
    end,
  },
}

-- ── Configurer un serveur précis (API native 0.11+) ─────────────────────────
-- Crée `~/.config/nvim/lua/../../lsp/lua_ls.lua` (dossier `lsp/` à la racine du
-- runtimepath, donc `~/.config/nvim/lsp/lua_ls.lua`) qui renvoie :
--
--   return {
--     settings = {
--       Lua = { hint = { enable = true } },
--     },
--   }
--
-- Neovim le fusionne automatiquement par-dessus les défauts de nvim-lspconfig.
-- (Pour lua_ls + ta config Neovim, lazydev.nvim gère déjà le global `vim` et
-- les fichiers runtime — pas besoin de le refaire à la main.)
