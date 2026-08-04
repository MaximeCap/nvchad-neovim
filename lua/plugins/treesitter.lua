-- Treesitter — branche `main` (Neovim 0.12+).
--
-- ⚠️ La branche `master` historique est gelée / plus maintenue. La branche
-- `main` réécrit complètement l'API :
--   * plus de `require("nvim-treesitter.configs").setup { highlight = ... }`
--   * highlight / indent / folds s'activent à la main dans un autocmd FileType
--     via les API natives `vim.treesitter.*`
--   * pas de lazy-loading → `lazy = false` est OBLIGATOIRE
--   * pas d'`auto_install` natif → on le reconstruit ci-dessous
--
-- 🔧 Dépendance toolchain : `main` télécharge + COMPILE les parsers. Il faut
--    donc le CLI `tree-sitter` (>= 0.26.1, à installer via brew/cargo — PAS npm)
--    ET un compilateur C. Le CLI tree-sitter tire historiquement node ; si le
--    toolchain manque, on dégrade en douceur (cf. `toolchain_ok` plus bas) :
--    aucune install, on se contente des parsers déjà compilés, et on prévient.

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require "nvim-treesitter"
      local ts_config = require "nvim-treesitter.config"

      -- Parsers qu'on veut garder installés en permanence.
      local ensure_installed = {
        "tsx",
        "html",
        "go",
        "yaml",
        "helm",
        -- bases utiles pour éditer Neovim/Lua + markdown
        "lua",
        "luadoc",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
      }

      ts.setup {}

      -- ── Détection du toolchain requis par la branche main ──────────────
      local function has(bin)
        return vim.fn.executable(bin) == 1
      end
      local toolchain_ok = has "tree-sitter" and (has "cc" or has "gcc" or has "clang")

      if not toolchain_ok then
        vim.schedule(function()
          vim.notify(
            "nvim-treesitter (main) : CLI `tree-sitter` ou compilateur C absent.\n"
              .. "→ Auto-install désactivé, seuls les parsers déjà compilés sont utilisés.\n"
              .. "Pour réactiver : installe le CLI (`brew install tree-sitter` ou `cargo install tree-sitter-cli`).",
            vim.log.levels.WARN,
            { title = "treesitter" }
          )
        end)
      else
        -- Install / mise à jour de la liste de base, en async (non bloquant).
        ts.install(ensure_installed)
      end

      -- ── Helpers ────────────────────────────────────────────────────────
      local function parser_installed(lang)
        return lang ~= nil and vim.list_contains(ts_config.get_installed "parsers", lang)
      end

      -- Un parser existe-t-il réellement upstream ? Garde-fou indispensable :
      -- des filetypes synthétiques (snacks_picker_input, oil, ...) font que
      -- `get_lang` retombe sur le nom du filetype, et sans ce filtre on tente
      -- d'installer un parser inexistant → "skipping unsupported language".
      local function parser_available(lang)
        return lang ~= nil and vim.list_contains(ts_config.get_available(), lang)
      end

      -- Active highlight + indent treesitter pour un buffer.
      local function enable_ts(buf, lang)
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end
        pcall(vim.treesitter.start, buf, lang)
        -- Indentation pilotée par treesitter (commente si un langage te gêne).
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end

      -- Logique appliquée à un buffer : démarre si le parser est là, sinon
      -- (si le toolchain le permet) install à la volée puis démarre.
      local function on_buf(buf)
        -- On ignore les buffers spéciaux (pickers, prompts, oil, ...).
        if vim.bo[buf].buftype ~= "" then
          return
        end

        local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
        if not lang then
          return
        end

        if parser_installed(lang) then
          enable_ts(buf, lang)
        elseif toolchain_ok and parser_available(lang) then
          ts.install({ lang }):await(function(err)
            if err then
              return
            end
            vim.schedule(function()
              enable_ts(buf, lang)
            end)
          end)
        end
        -- Si le toolchain manque et le parser n'est pas là : on ne fait rien
        -- (le buffer reste en highlight regex Vim classique).
      end

      -- ── Activation à l'ouverture de chaque FileType ────────────────────
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("nvim_treesitter_start", { clear = true }),
        callback = function(args)
          on_buf(args.buf)
        end,
      })

      -- Rattrape les buffers déjà ouverts avant le chargement du plugin.
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
          on_buf(buf)
        end
      end

      -- ── Folds treesitter (optionnel — décommente si tu veux) ───────────
      -- vim.o.foldmethod = "expr"
      -- vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      -- vim.o.foldlevel = 99
    end,
  },
}
