return {
  {
    'voldikss/vim-floaterm',
    config = function()
      vim.g.floaterm_width = 0.7
      vim.g.floaterm_height = 0.8
      vim.keymap.set('n', '<A-i>', ':FloatermToggle<CR>')
      vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>:FloatermToggle<CR>')
    end,
  },
}
