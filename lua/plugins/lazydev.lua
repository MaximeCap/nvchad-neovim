-- lazydev — configure lua_ls pour l'édition de la config Neovim elle-même :
-- résout le global `vim`, les modules runtime, et les types des plugins
-- référencés via `---@module` / `---@type` dans les specs lazy.
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      -- Types luvit chargés seulement quand `vim.uv` apparaît dans le buffer.
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
