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
      -- vim.cmd.colorscheme 'tokyonight'
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'Mofiqul/vscode.nvim',
    init = function()
      -- For dark theme (neovim's default)
      vim.o.background = 'dark'

      local c = require('vscode.colors').get_colors()
      require('vscode').setup {
        -- Override highlight groups (see ./lua/vscode/theme.lua)
        group_overrides = {
          -- this supports the same val table as vim.api.nvim_set_hl
          -- use colors from this colorscheme by requiring vscode.colors!
          DiffAdd = { fg = 'NONE', bg = '#637345' },
          Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
        },
      }
      -- require('vscode').load()

      -- load the theme without affecting devicon colors.
      vim.cmd.colorscheme 'vscode'
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    init = function()
      vim.cmd.colorschemes = 'carbonfox'
    end,
  },
  {
    'nyoom-engineering/oxocarbon.nvim',
    init = function()
      -- vim.cmd.colorscheme 'oxocarbon'
    end,
  },
  {
    'rockyzhang24/arctic.nvim',
    branch = 'v2',
    dependencies = { 'rktjmp/lush.nvim' },
    init = function()
      -- vim.cmd.colorscheme 'arctic'
    end,
  },
  {
    'darianmorat/gruvdark.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    init = function()
      -- vim.cmd.colorscheme 'gruvdark'
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
