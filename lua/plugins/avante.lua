local avante_repo = "https://github.com/yetone/avante.nvim"

vim.pack.add {
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  avante_repo,
}

require("avante").setup {
  provider = "codex",
  acp_providers = {
    ["opencode"] = {
      command = "opencode",
      args = { "acp" },
    },
    ["codex"] = {
      command = "npx",
      args = { "@zed-industries/codex-acp" },
      env = {
        NODE_NO_WARNINGS = "1",
        OPENAI_API_KEY = os.getenv "AVANTE_OPENAI_API_KEY",
      },
    },
  },
  providers = {
    openai = {
      endpoint = "http://localhost:8080/openai/v1",
      model = "gpt-5.3-codex",
      disable_tools = true,
    },
    claude = {
      auth_type = "pro",
    },
  },
  selector = {
    provider = "snacks",
    provider_opts = {},
  },
  input = {
    provider = "snacks",
    provider_opts = {
      -- Additional snacks.input options
      title = "Avante Input",
      icon = " ",
    },
  },
}
