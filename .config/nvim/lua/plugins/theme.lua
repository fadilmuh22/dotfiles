return {
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  {
    'rebelot/kanagawa.nvim',
    init = function()
      -- vim.cmd.colorscheme 'kanagawa'
    end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- vim.cmd.colorscheme 'tokyonight-night'
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'Mofiqul/vscode.nvim',
    init = function()
      vim.cmd.colorscheme 'vscode'
    end,
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
}
-- vim: ts=2 sts=2 sw=2 et
