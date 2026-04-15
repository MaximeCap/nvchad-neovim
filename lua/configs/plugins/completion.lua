vim.pack.add {
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range "^1" },
}

return {
  fuzzy = { implementation = "prefer_rust_with_warning" },
  signature = { enabled = true },
  keymap = {
    preset = "cmdline",
  },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },

  completion = {
    ghost_text = { enabled = true },
    accept = {
      auto_brackets = { enabled = true },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
  },

  cmdline = {
    enabled = true,
  },

  sources = { default = { "lsp" } },
}
