vim.pack.add { "https://github.com/obsidian-nvim/obsidian.nvim" }
require("obsidian").setup {

  legacy_commands = false, -- this will be removed in the next major release
  workspaces = {
    {
      name = "personal",
      path = "~/vaults/personal",
    },
    {
      name = "work",
      path = "~/vaults/work",
    },
  },
}
