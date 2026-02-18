require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "rust_analyzer",
  "delve",
  "biome",
  "vtsls",
  "gopls",
  "eslint",
  "basedpyright",
  "ruff",
  "lua_ls",
  "debugpy",
  "tailwindcss",
  "yamlls",
  "dockerls",
}

vim.lsp.enable(servers)

-- Configure lua_ls for Neovim development
vim.lsp.config.lua_ls = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
        },
        checkThirdParty = false,
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}

-- read :h vim.lsp.config for changing options of lsp servers
