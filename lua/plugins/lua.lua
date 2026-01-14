return {
  {
    "folke/neodev.nvim",
    ft = "lua",
    config = function()
      require("neodev").setup {
        library = {
          plugins = true, -- Load plugin types
          types = true, -- Load vim types
        },
      }
    end,
  },
}
