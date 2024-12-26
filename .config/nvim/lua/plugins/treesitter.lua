return {
  {
    'chrisgrieser/nvim-various-textobjs',
    event = 'VeryLazy',
    opts = {
      keymaps = {
        useDefaults = true,
      },
    },
    config = function(_, opts)
      vim.keymap.set('n', 'gx', function()
        require('various-textobjs').setup(opts)

        -- select URL
        require('various-textobjs').url()

        -- plugin only switches to visual mode when textobj is found
        local foundURL = vim.fn.mode() == 'v'
        if not foundURL then
          return
        end

        -- retrieve URL with the z-register as intermediary
        vim.cmd.normal { '"zy', bang = true }
        local url = vim.fn.getreg 'z'
        vim.ui.open(url) -- requires nvim 0.10
      end, { desc = 'URL Opener' })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      max_lines = 3,
    },
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    dependencies = {
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        opts = {
          custom_calculation = function(_, language_tree)
            if vim.bo.filetype == 'blade' and language_tree._lang ~= 'javascript' and language_tree._lang ~= 'php' then
              return '{{-- %s --}}'
            end
          end,
        },
      },
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'go',
        'rust',
        'zig',
        'typescript',
        'javascript',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

      parser_config.blade = {
        install_info = {
          url = 'https://github.com/EmranMR/tree-sitter-blade',
          files = { 'src/parser.c' },
          branch = 'main',
        },
        filetype = 'blade',
      }

      vim.filetype.add {
        pattern = {
          ['.*%.blade%.php'] = 'blade',
          ['.*%.html'] = 'htmldjango',
          ['.*%.html%.jinja'] = 'htmldjango',
          ['.*%.html%.jinja2'] = 'htmldjango',
          ['.*%.html%.j2'] = 'htmldjango',
        },
      }

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
        pattern = { '*.norg' },
        command = 'set conceallevel=3',
      })

      vim.api.nvim_create_user_command('TSRestoreHighlight', function()
        vim.cmd 'write | edit | TSBufEnable highlight'
      end, { desc = 'Restore Treesitter highlight after saving' })

      -- keymap
      vim.keymap.set('n', '<leader>tr', '<CMD>TSRestoreHighlight<CR>', { noremap = true, silent = true, desc = '[T]ree-sitter [r]estore highlight' })

      require('nvim-treesitter.configs').setup(opts)
    end,
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
}
-- vim: ts=2 sts=2 sw=2 et
