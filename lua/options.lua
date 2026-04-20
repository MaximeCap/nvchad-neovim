-- require "nvchad.options"

-- add yours here!

local o = vim.o
o.number = true
o.relativenumber = true
o.autoindent = true -- Enable auto indentation
o.expandtab = true -- Use spaces instead of tabs
o.tabstop = 2 -- Number of spaces for a tab
o.softtabstop = 2 -- Number of spaces for a tab when editing
o.shiftwidth = 2 -- Number of spaces for autoindent
o.conceallevel = 2
o.termguicolors = true
o.undofile = true
o.swapfile = false
o.completeopt = "menuone,noselect,fuzzy,popup"
o.winborder = "rounded"
o.ignorecase = true
o.cmdheight = 0

-- TODO see the effect
o.cursorlineopt = "both" -- to enable cursorline!
o.inccommand = "split"
o.cursorline = true
o.textwidth = 100
-- o.listchars = "tab: ,multispace:|   ,space:·"
-- o.list = true
o.clipboard = "unnamedplus"
