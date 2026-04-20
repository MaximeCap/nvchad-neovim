-- vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

require "options"
require "autocmds"
require "mappings"

vim.schedule(function()
  require "configs"
end)

vim.pack.add { "https://github.com/rose-pine/neovim" }
vim.cmd "colorscheme rose-pine"
