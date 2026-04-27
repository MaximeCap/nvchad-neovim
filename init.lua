-- vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

require "config.options"
require "config.autocmds"
require "config.mappings"

vim.schedule(function()
  require "config"
end)

vim.pack.add { "https://github.com/rose-pine/neovim" }
require("rose-pine").setup {
  styles = {
    transparency = true,
  },
}

vim.cmd "colorscheme rose-pine"
