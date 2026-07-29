local ensure = require("config.lazy").loader({
  "https://github.com/hedengran/fga.nvim",
}, function()
  require "fga"
end)

ensure()
