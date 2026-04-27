vim.pack.add { "https://www.github.com/nvim-lua/plenary.nvim" }
vim.pack.add {
  {
    src = "https://www.github.com/olimorris/codecompanion.nvim",
    version = vim.version.range "^19.0.0",
  },
}

local progress = require "fidget.progress"
local handles = {}
local group = vim.api.nvim_create_augroup("CodeCompanionFidget", {})

vim.api.nvim_create_autocmd("User", {
  pattern = "CodeCompanionRequestStarted",
  group = group,
  callback = function(e)
    handles[e.data.id] = progress.handle.create {
      title = "CodeCompanion",
      message = "Thinking...",
      lsp_client = { name = e.data.adapter.formatted_name },
    }
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "CodeCompanionRequestFinished",
  group = group,
  callback = function(e)
    local h = handles[e.data.id]
    if h then
      h.message = e.data.status == "success" and "Done" or "Failed"
      h:finish()
      handles[e.data.id] = nil
    end
  end,
})

-- Somewhere in your config
require("codecompanion").setup {
  adapters = {
    http = {
      -- opts = {
      --   allow_insecure = true,
      --   proxy = "http://localhost:8080/openai/v1",
      -- },
      openai_responses = function()
        return require("codecompanion.adapters").extend("openai_responses", {

          --url = "http://localhost:8080/openai/v1/responses",
          env = {},
          schema = {
            top_p = {
              optional = true,
              enabled = function()
                return false
              end,
            },
          },
        })
      end,
    },
  },
  interactions = {
    chat = {
      adapter = {
        name = "openai_responses",
        model = "gpt-5.3-codex",
      },
    },
  },
}
