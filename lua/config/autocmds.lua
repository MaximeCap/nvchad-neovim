-- require "nvchad.autocmds"
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  pattern = "*",
  desc = "highlight selection on yank",
  callback = function()
    vim.highlight.on_yank { timeout = 200, visual = true }
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("n", "K", vim.lsp.buf.hover, "LSP Hover")
    map("n", "gd", function()
      Snacks.picker.lsp_definitions()
    end, "Go to definition")
    map("n", "gD", function()
      Snacks.picker.lsp_declarations()
    end, "Go to declaration")
    map("n", "gi", function()
      Snacks.picker.lsp_implementations()
    end, "Go to implementation")
    map("n", "gr", function()
      Snacks.picker.lsp_references()
    end, "References")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>lf", function()
      vim.lsp.buf.format { async = true }
    end, "Format buffer (LSP)")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    -- syntax highlighting, provided by Neovim
    pcall(vim.treesitter.start)
    -- folds, provided by Neovim
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    vim.wo.foldenable = false
  end,
})
