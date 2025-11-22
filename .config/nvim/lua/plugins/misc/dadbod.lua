return {
  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-completion',
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_execute_on_save = 0

      -- 1. Keymap configuration: Enforce selection for execution
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'sql', 'mysql', 'plsql' },
        callback = function()
          -- Visual Mode (x): Run the selected query
          vim.keymap.set('x', '<leader>S', '<Plug>(DBUI_ExecuteQuery)', {
            buffer = true,
            desc = 'Execute selected SQL query',
          })

          -- Normal Mode (n): Show warning instead of running
          vim.keymap.set('n', '<leader>S', function()
            vim.notify('⚠️  Selection required: Highlight lines to run query.', vim.log.levels.WARN)
          end, {
            buffer = true,
            desc = 'Warn: Select query to run',
          })
        end,
      })

      -- 2. Auto-open DBUI if in the specific directory
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          -- Expand user path (~) to absolute path for accurate comparison
          local target_dir = vim.fn.expand '~/.local/share/db_ui'

          if vim.fn.getcwd() == target_dir then
            vim.cmd 'DBUI'
          end
        end,
      })
    end,
  },
}
