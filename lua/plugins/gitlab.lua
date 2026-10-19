return {
  "harrisoncramer/gitlab.nvim",
  -- branch = "main", -- Uncomment to use a stable version. The default, possibly unstable, but more actively maintained branch is `develop`.
  dependencies = {
    "MunifTanjim/nui.nvim",
    "dlyongemallo/diffview-plus.nvim", -- Maintained fork of "sindrets/diffview.nvim".
    "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
    "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
  },
  ---@type GitlabSettings
  opts = {}, -- Your configuration
  keys = {
    {
      "<leader>rr",
      function()
        require("gitlab").choose_merge_request()
      end,
    },
  },
}
