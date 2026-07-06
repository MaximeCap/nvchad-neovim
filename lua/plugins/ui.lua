return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function(_, opts)
    local state_file = vim.fn.stdpath "state" .. "/bg_state"

    -- Restore saved background (dark -> wave/dragon, light -> lotus) before paint.
    local f = io.open(state_file, "r")
    if f then
      local saved_bg = f:read "*l"
      f:close()
      if saved_bg == "dark" or saved_bg == "light" then
        vim.o.background = saved_bg
      end
    end

    require("kanagawa").setup(opts)
    vim.cmd "colorscheme kanagawa"

    local function toggle_background()
      local new_bg = vim.o.background == "dark" and "light" or "dark"
      vim.o.background = new_bg

      local file = io.open(state_file, "w")
      if file then
        file:write(new_bg)
        file:close()
        print("Background set to " .. new_bg .. " (saved)")
      end
    end

    vim.keymap.set("n", "<leader>us", toggle_background, { desc = "Toggle between light and dark" })
  end,
}
