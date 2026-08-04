return {
  {
    "qvalentin/helm-ls.nvim",
    ft = "helm",
    init = function()
      vim.filetype.add {
        pattern = {
          [".*/templates/.*%.yaml"] = "helm",
          [".*/templates/.*%.yml"] = "helm",
        },
      }
    end,
    opts = {},
  },
}
