vim.pack.add { "https://github.com/windwp/nvim-ts-autotag" }

require("nvim-ts-autotag").setup {
  opts = {
    enable_close = true, -- auto close tags
    enable_rename = true, -- auto rename pairs of tags
    enable_close_on_slash = true, -- auto close when typing </
  },
}
