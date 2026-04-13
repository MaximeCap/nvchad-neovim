-- require "nvchad.options"

-- add yours here!

local o = vim.o
o.relativenumber = true
o.autoindent = true -- Enable auto indentation
o.expandtab = true -- Use spaces instead of tabs
o.tabstop = 2 -- Number of spaces for a tab
o.softtabstop = 2 -- Number of spaces for a tab when editing
o.shiftwidth = 2 -- Number of spaces for autoindent
o.conceallevel = 2

o.completeopt = "menuone,noselect,fuzzy"
o.cursorlineopt = "both" -- to enable cursorline!
