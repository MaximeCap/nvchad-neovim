vim.pack.add { "https://github.com/obsidian-nvim/obsidian.nvim" }

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  once = true,
  callback = function()
    require("obsidian").setup {
      legacy_commands = false,
      workspaces = {
        { name = "personal", path = "~/vaults/personal" },
        { name = "work", path = "~/vaults/work" },
      },
    }
  end,
})
