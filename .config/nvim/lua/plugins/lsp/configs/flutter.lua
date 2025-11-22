return {
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    opts = {
      root_patterns = { '.git' },
      debugger = {
        enable = true,
      },
      lsp = {
        color = {
          enabled = true,
          background = true,
        },
      },
    },
  },
}