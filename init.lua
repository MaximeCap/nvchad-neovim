-- vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

require "options"
require "autocmds"
require "configs"
require "mappings"

vim.pack.add { "https://github.com/rose-pine/neovim" }
vim.cmd "colorscheme rose-pine"

-- Old configuration nvim 0.11.4 with Lazyvim

-- bootstrap lazy and all plugins
-- local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
--
-- if not vim.uv.fs_stat(lazypath) then
--   local repo = "https://github.com/folke/lazy.nvim.git"
--   vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
-- end
--
-- vim.opt.rtp:prepend(lazypath)
--
-- local lazy_config = require "configs.lazy"
--
-- -- load plugins
-- require("lazy").setup({
--   {
--     "NvChad/NvChad",
--     lazy = false,
--     branch = "v2.5",
--     import = "nvchad.plugins",
--   },
--
--   { import = "plugins" },
-- }, lazy_config)

-- load theme
-- dofile(vim.g.base46_cache .. "defaults")
-- dofile(vim.g.base46_cache .. "statusline")

-- vim.schedule(function()
--   require "mappings"
-- end)
