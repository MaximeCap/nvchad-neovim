return {
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      -- Only one of these is needed.
      "esmuellert/codediff.nvim", -- optional
      -- For a custom log pager
      "m00qek/baleia.nvim", -- optional
      "folke/snacks.nvim", -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
    },
  },
  {
    "sindrets/diffview.nvim",
    opts = {},
  },
  -- Gitsigns — chargé tôt (sur ouverture d'un vrai fichier) car la statusline
  -- lit `vim.b.gitsigns_*`. Toutes les maps git vivent dans `on_attach` : elles
  -- ne sont posées que sur les buffers réellement suivis par git.
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require "gitsigns"

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation des hunks (respecte le mode diff natif).
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal { "]c", bang = true }
          else
            gitsigns.nav_hunk "next"
          end
        end, { desc = "Next hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal { "[c", bang = true }
          else
            gitsigns.nav_hunk "prev"
          end
        end, { desc = "Prev hunk" })

        -- Actions
        map("n", "<leader>hb", function()
          gitsigns.blame_line { full = true }
        end, { desc = "Blame line" })
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" })
        map("n", "<leader>hD", function()
          gitsigns.diffthis "~"
        end, { desc = "Diff this ~" })
        map("n", "<leader>hQ", function()
          gitsigns.setqflist "all"
        end, { desc = "Hunks → qflist (all)" })
        map("n", "<leader>hq", gitsigns.setqflist, { desc = "Hunks → qflist" })

        -- Toggles
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
        map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" })
      end,
    },
  },

  -- Lazygit — chargé à la demande (commande ou keymap).
  {
    "kdheepak/lazygit.nvim",
    enabled = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Lazygit" },
    },
  },
}
