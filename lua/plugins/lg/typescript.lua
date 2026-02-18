return {
  {
    "windwp/nvim-ts-autotag",
    ft = { "typescriptreact", "tsx", "html" },
    config = function(_, opts)
      require("nvim-ts-autotag").setup(vim.tbl_deep_extend("force", opts, {
        opts = {
          enable_close_on_slash = true,
        },
      }))
    end,
  },
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    config = function()
      local dap = require "dap"
      dap.adapters = {
        ["pwa-node"] = {
          type = "server",
          port = "${port}",
          executable = {
            command = "js-debug-adapter",
            args = {
              "${port}",
            },
          },
        },
        ["pwa-chrome"] = {
          type = "executable",
          command = "node",
        },
      }

      dap.configurations.typescriptreact = {
        {
          name = "Debug in Chrome",
          type = "pwa-chrome",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceRoot}",
        },
      }
    end,
  },
}
