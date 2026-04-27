vim.pack.add { "https://github.com/romus204/tree-sitter-manager.nvim" }

require("tree-sitter-manager").setup {
  ensure_installed = {
    "tsx",
    "html",
    "go",
  },
  auto_install = true,
}
