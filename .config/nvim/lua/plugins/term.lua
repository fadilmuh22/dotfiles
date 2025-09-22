return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      local toggle_term = require 'toggleterm'
      toggle_term.setup {
        auto_scroll = false,
        start_in_insert = true,
      }

      vim.keymap.set('n', '<A-i>', ':ToggleTerm name=float direction=float<CR>', { desc = 'Toggle terminal float' })
      vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>:ToggleTerm name=float<CR>', { desc = 'Close terminal float' })

      vim.keymap.set(
        'n',
        '<A-\\>',
        ':ToggleTerm name=vert direction=vertical size=70<CR>',
        { desc = 'Toggle terminal vertical', noremap = true, silent = true }
      )
      vim.keymap.set('t', '<A-\\>', '<C-\\><C-n><CMD>:ToggleTerm name=vert<CR>', { desc = 'Close terminal vertical', noremap = true, silent = true })

      local Terminal = require('toggleterm.terminal').Terminal
      local gemini = Terminal:new { cmd = 'gemini', hidden = true, direction = 'vertical' }

      function ToggleGemini()
        gemini:toggle()
        gemini:resize(75)
        gemini.auto_scroll = false
      end

      vim.api.nvim_set_keymap('n', '<A-g>', '<cmd>lua ToggleGemini()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('t', '<A-g>', '<C-\\><C-n><cmd>lua ToggleGemini()<CR>', { noremap = true, silent = true })
    end,
  },
}
