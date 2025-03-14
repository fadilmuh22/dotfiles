return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    { '<leader>wr', '<cmd>SessionSearch<CR>', desc = 'Session search' },
    { '<leader>we', '<cmd>SessionSave<CR>', desc = 'Session save' },
    { '<leader>wd', '<cmd>SessionDelete<CR>', desc = 'Session delete' },
    { '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Session autosave' },
  },

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/', '~/Downloads', '/' },
  },
}
