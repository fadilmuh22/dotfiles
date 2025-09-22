return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
  config = function(_, opts)
    local oil = require 'oil'

    oil.setup(opts)
    vim.api.nvim_set_keymap('n', '<leader>-', '<cmd>lua require(\'oil\').toggle_float()<CR>', { noremap = true, silent = true })

    vim.api.nvim_create_user_command('Explore', function()
      oil.open()
    end, { desc = 'Open Oil file explorer' })
  end,
}
