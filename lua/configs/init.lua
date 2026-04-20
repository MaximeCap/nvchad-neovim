vim.pack.add {
  "https://github.com/mplusp/pack-manager.nvim",
}

-- Fzf-lua
vim.pack.add { "https://github.com/ibhagwan/fzf-lua" }
require("fzf-lua").setup {
  ui_select = true,
}

vim.keymap.set("n", "<leader><leader>", "<cmd>FzfLua files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua helptags<cr>")
vim.keymap.set("n", "<leader>fws", "<cmd>FzfLua lsp_workspace_symbols<cr>")

-- Mini configuration
vim.pack.add { "https://github.com/nvim-mini/mini.nvim" }
require("mini.pairs").setup {}
require("mini.icons").setup {}

vim.pack.add { "https://github.com/lewis6991/gitsigns.nvim" }

require("gitsigns").setup {
  on_attach = function(bufnr)
    local gitsigns = require "gitsigns"

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal { "]c", bang = true }
      else
        gitsigns.nav_hunk "next"
      end
    end)

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal { "[c", bang = true }
      else
        gitsigns.nav_hunk "prev"
      end
    end)

    map("n", "<leader>hb", function()
      gitsigns.blame_line { full = true }
    end)

    map("n", "<leader>hd", gitsigns.diffthis)

    map("n", "<leader>hD", function()
      gitsigns.diffthis "~"
    end)

    map("n", "<leader>hQ", function()
      gitsigns.setqflist "all"
    end)
    map("n", "<leader>hq", gitsigns.setqflist)

    -- Toggles
    map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
    map("n", "<leader>tw", gitsigns.toggle_word_diff)
  end,
}

-- Oil configuration
vim.pack.add { "https://github.com/stevearc/oil.nvim" }

require("oil").setup {
  win_options = {
    signcolumn = "yes:1",
  },
  view_options = {
    show_hidden = true,
  },
}

vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>")

-- Completion configuration
require "configs.plugins.completion"

-- Conform configuration
require "configs.plugins.conform"

-- LSP Plugin configuration
require "configs.plugins.lsp"

-- Lazydev
require "configs.plugins.lazydev"

-- Treesitter Manager
require "configs.plugins.treesitter"

-- Obsidian
require "configs.plugins.obsidian"

-- Debug configuration
require "configs.plugins.dap"

-- statusline
require "configs.statusline"
