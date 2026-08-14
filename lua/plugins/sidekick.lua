local function cli()
  return require "sidekick.cli"
end

return {
  "folke/sidekick.nvim",
  opts = {
    nes = {
      enabled = false,
    },
  },
  dependencies = {
    "folke/snacks.nvim",
  },
  keys = {
    { "<C-\\>", function() cli().toggle() end, mode = { "n", "v", "i", "t" }, desc = "Toggle Sidekick" },
    { "<C-'>", function() cli().send { msg = "{selection}" } end, mode = "v", desc = "Send selection to Sidekick" },
    { "<C-'>", function() cli().send { msg = "{file}" } end, mode = "n", desc = "Send file to Sidekick" },
    { "<C-,>", function() cli().select() end, mode = { "n", "v", "i" }, desc = "Select Sidekick CLI" },

    { "<leader>aa", function() cli().toggle() end, mode = { "n", "v", "i", "t" }, desc = "Toggle CLI" },
    { "<leader>ac", function() cli().send { msg = "{selection}" } end, mode = "v", desc = "Send selection" },
    { "<leader>ac", function() cli().send { msg = "{file}" } end, mode = "n", desc = "Send file" },
    { "<leader>an", function() cli().select() end, mode = { "n", "v", "i" }, desc = "Select CLI" },
    { "<leader>ap", function() cli().prompt() end, mode = { "n", "v" }, desc = "Prompt" },
  },
}
