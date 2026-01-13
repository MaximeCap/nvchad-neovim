return {
	{
		"stevearc/oil.nvim",
    lazy = false,
		cmd = "Oil",
		keys = {
			{ "<leader>e", "<cmd>Oil<cr>" },
		},
		dependencies = {
			"refractalize/oil-git-status.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			win_options = {
				signcolumn = "yes:2",
			},
			view_options = {
				show_hidden = true,
			},
		},
		config = function(_, opts)
			require("oil").setup(opts)
			require("oil-git-status").setup({
				show_ignored = false,
			})
		end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      input = { enabled = true },
      picker = { enabled = true },
    }
  }
}
