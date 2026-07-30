vim.g.mapleader = " "
vim.g.maplocalleader = ","

local o = vim.o

-- Indentation
o.autoindent = true -- Enable auto indentation
o.expandtab = true -- Use spaces instead of tabs
o.tabstop = 2 -- Number of spaces for a tab
o.softtabstop = 2 -- Number of spaces for a tab when editing
o.shiftwidth = 2 -- Number of spaces for autoindent
o.breakindent = true -- wrapped lines preserve indentation

-- UI
o.number = true
o.relativenumber = true
o.termguicolors = true
o.winborder = "rounded"
o.signcolumn = "yes" -- always show the sign column (prevents text jitter)
o.cursorline = true
o.cursorlineopt = "both"
o.conceallevel = 2
o.cmdheight = 1
o.wrap = false
o.linebreak = true -- if wrap is toggled on, break at word boundaries
o.textwidth = 100

-- Search
o.ignorecase = true
o.smartcase = true -- case-sensitive search if an uppercase char is typed
o.inccommand = "split"

-- Files
o.undofile = true
o.swapfile = false
o.completeopt = "menuone,noselect,fuzzy,popup"
o.clipboard = "unnamedplus"

-- Splits & scrolling
o.splitright = true -- vertical splits open to the right
o.splitbelow = true -- horizontal splits open below
o.scrolloff = 8 -- keep 8 lines visible around the cursor
o.sidescrolloff = 8
o.smoothscroll = true -- wrap-aware scrolling for <C-d>/<C-u> (0.10+)

-- QoL
o.title = true -- set terminal window title to current file
o.autoread = true -- reload buffer if file changes on disk outside nvim
o.confirm = true -- prompt to save instead of failing on :q with unsaved changes
o.updatetime = 250 -- faster CursorHold & gitsigns blame
o.timeoutlen = 400 -- snappier leader chords
o.jumpoptions = "stack,view" -- saner jumplist behavior
o.virtualedit = "block" -- free-form movement in visual-block mode

-- Diagnostics — UI globale, posée au démarrage (indépendante du plugin LSP).
vim.diagnostic.config {
  severity_sort = true,
  update_in_insert = false, -- évite le flicker pendant la saisie
  underline = true,
  float = {
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticError",
      [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticHint",
    },
  },
  virtual_text = {
    spacing = 2,
    source = "if_many",
    prefix = "●",
  },
}
