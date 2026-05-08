vim.g.mapleader = " "

require "config.options"

-- Tier 1 — pre-paint: colorscheme so the very first frame is correct.
vim.pack.add { "https://github.com/rose-pine/neovim" }
require("rose-pine").setup {
  styles = {
    transparency = false,
  },
}
vim.cmd "colorscheme rose-pine"

-- Pure-Lua statusline; no plugin deps.
require "config.statusline"

require "config.mappings"
require "config.autocmds"

-- Tier 2 — scheduled: stand up Oil + Snacks before the user can press a key.
vim.schedule(function()
  -- Oil
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

  -- mini.nvim shell — needed for icons (Oil + statusline) and
  -- pairs/surround which load lazily later.
  vim.pack.add { "https://github.com/nvim-mini/mini.nvim" }
  require("mini.icons").setup {}

  -- Snacks
  vim.pack.add { "https://github.com/folke/snacks.nvim" }
  require("snacks").setup {
    input = { enabled = true },
    picker = { enabled = true, layout = "ivy" },
  }
  local map = vim.keymap.set
  map("n", "<leader><leader>", function()
    Snacks.picker.files()
  end)
  map("n", "<leader>fg", function()
    Snacks.picker.grep()
  end)
  map("n", "<leader>fb", function()
    Snacks.picker.buffers()
  end)
  map("n", "<leader>fh", function()
    Snacks.picker.help()
  end)
  map("n", "<leader>fws", function()
    Snacks.picker.lsp_workspace_symbols()
  end)

  -- Tier 3 — register lazy triggers for everything else.
  require "config"
end)
