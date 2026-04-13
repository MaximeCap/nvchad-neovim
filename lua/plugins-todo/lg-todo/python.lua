return {
  {
    "alexpasmantier/pymple.nvim",
    dependencies = {
      -- "vim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- optional (nicer ui)
      -- "stevearc/dressing.nvim",
      -- "nvim-tree/nvim-web-devicons",
    },
    build = ":PympleBuild",
    config = function(_, opts)
      require("pymple").setup(opts)
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = { "python" },
    config = function()
      local dap_python = require "dap-python"
      dap_python.setup "uv"
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    cmd = "VenvSelect",
    opts = {
      options = {
        notify_user_on_venv_activation = true,
      },
    },
    --  Call config for Python files and load the cached venv automatically
    ft = "python",
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  },
}
