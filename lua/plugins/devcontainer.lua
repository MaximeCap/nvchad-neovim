return {
  {
    "https://codeberg.org/esensar/nvim-dev-container",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = "*/.devcontainer/",
        callback = function()
          require("devcontainer").setup {}
        end,
      })
    end,
  },
}
