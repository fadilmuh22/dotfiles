return {
  {
    'karb94/neoscroll.nvim',
    opts = {},
    config = function()
      local neoscroll = require 'neoscroll'
      neoscroll.setup {
        pre_hook = function()
          vim.opt.eventignore:append {
            'WinScrolled',
            'CursorMoved',
          }
        end,
        post_hook = function()
          vim.opt.eventignore:remove {
            'WinScrolled',
            'CursorMoved',
          }
        end,
      }
    end,
  },
}
