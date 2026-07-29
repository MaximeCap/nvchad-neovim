-- likec4.nvim — support des diagrammes LikeC4 (architecture-as-code).
--
-- Migration depuis l'ancien loader `vim.pack` vers une spec lazy.nvim.
--
-- ⚠️ Ce plugin n'expose AUCUN module Lua (`require("likec4")` n'existe pas). Il
--    est 100 % déclaratif :
--      * `ftdetect/`         → enregistre le filetype `likec4` (.c4, .likec4…)
--      * `ftplugin/likec4.lua` → highlights, commentstring, et appelle lui-même
--                                `vim.lsp.enable("likec4")`
--      * `lsp/likec4.lua`    → config LSP (`cmd = { "likec4", "lsp", "--stdio" }`)
--
-- Lazy-loading via `ft = "likec4"` : lazy.nvim charge en amont les `ftdetect/`
-- du plugin, donc la détection du filetype marche AVANT le chargement. Ouvrir un
-- fichier LikeC4 déclenche le plugin, qui active le LSP tout seul — on n'a donc
-- rien à activer manuellement ici.
--
-- 🔧 Le LSP a besoin du CLI `likec4` (`npm install -g likec4`). S'il est absent,
--    on neutralise l'auto-activation faite par le ftplugin (pour éviter que
--    Neovim tente de spawn un binaire manquant) et on prévient — SANS jamais
--    tenter d'installer quoi que ce soit.

return {
  {
    "likec4/likec4.nvim",
    ft = "likec4",
    config = function()
      if vim.fn.executable "likec4" == 1 then
        return -- CLI présent : le ftplugin du plugin active le LSP tout seul.
      end

      -- CLI absent : cet autocmd s'exécute APRÈS le ftplugin (enregistré au
      -- démarrage, donc prioritaire) et re-désactive le serveur avant tout spawn.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "likec4",
        group = vim.api.nvim_create_augroup("likec4_no_lsp", { clear = true }),
        callback = function()
          vim.lsp.enable("likec4", false)
        end,
      })

      vim.schedule(function()
        vim.notify(
          "likec4.nvim : CLI `likec4` introuvable.\n"
            .. "→ LSP désactivé. Pour l'activer : `npm install -g likec4`.",
          vim.log.levels.WARN,
          { title = "likec4" }
        )
      end)
    end,
  },
}
