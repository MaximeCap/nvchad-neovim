vim.pack.add { "https://github.com/folke/flash.nvim" }

require("flash").setup {}

local map = vim.keymap.set

-- Jump to any location on screen with a 2-char label.
map({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash" })

-- Jump by treesitter node (select functions/blocks/args at a distance).
map({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })

-- Operator-pending: apply an action at a remote location (e.g. yr<label>).
map("o", "r", function()
  require("flash").remote()
end, { desc = "Remote Flash" })

-- Search + refine with treesitter nodes (great for larger selections).
map({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "Treesitter Search" })

-- Toggle flash labels inside `/` and `?` search.
map("c", "<c-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash Search" })
