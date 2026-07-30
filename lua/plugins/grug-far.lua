-- Try and remove if not useful
--
-- Search & replace multi-fichiers (ripgrep). Le buffer s'ouvre avec quatre
-- champs : Search / Replace / Files Filter / Flags. On tape dans les champs,
-- les résultats se rafraîchissent en direct, puis `<leader>r` applique.
return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  opts = {},
  keys = {
    {
      "<leader>sr",
      function()
        require("grug-far").open()
      end,
      desc = "Search & replace (project)",
    },
    {
      "<leader>sr",
      function()
        require("grug-far").with_visual_selection()
      end,
      mode = "v",
      desc = "Search & replace (selection)",
    },
    {
      "<leader>sf",
      function()
        require("grug-far").open { prefills = { paths = vim.fn.expand "%" } }
      end,
      desc = "Search & replace (current file)",
    },
  },
}
