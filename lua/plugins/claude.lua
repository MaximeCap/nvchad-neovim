return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },

  --- @type PartialClaudeCodeConfig
  opts = {},

  keys = {
    {
      "<A-\\>",
      "<cmd>ClaudeCode<cr>",
      mode = { "n", "v", "i" },
      desc = "Toggle Claude Code",
    },
    {
      "<A-'>",
      "<cmd>ClaudeCodeAdd %<cr>",
      mode = { "n" },
      desc = "Add file to Claude Code Context",
    },
    {
      "<A-'>",
      "<cmd>ClaudeCodeSend<cr>",
      mode = { "v" },
      desc = "Add selection to Claude Code Context",
    },
    {
      "<A-,>",
      "<cmd>ClaudeCode --continue<cr>",
      mode = { "n", "v", "i" },
      desc = "Continue Claude Code Session",
    },
    {
      "<A-i>r",
      "<cmd>ClaudeCode --resume<cr>",
      desc = "Claude Code Restore session",
      silent = true,
      mode = { "n", "v", "i" },
    },
  },
}
