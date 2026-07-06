local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "kanagawa" } },
  checker = {
    enabled = true,
    notify = false,
  },
}

-- local M = {}
--
-- -- Returns an idempotent loader. First call runs vim.pack.add(pack) and the
-- -- optional setup() callback; subsequent calls are no-ops.
-- --   local ensure = require("config.lazy").loader(
-- --     { "https://github.com/folke/flash.nvim" },
-- --     function() require("flash").setup {} end
-- --   )
-- function M.loader(pack, setup)
--   local loaded = false
--   return function()
--     if loaded then
--       return
--     end
--     loaded = true
--     if pack then
--       vim.pack.add(pack)
--     end
--     if setup then
--       setup()
--     end
--   end
-- end
--
-- return M
