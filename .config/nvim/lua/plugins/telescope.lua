-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  -- {
  --   'nvim-telescope/telescope-file-browser.nvim',
  --   dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  -- },
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'kkharji/sqlite.lua',
      'nvim-lua/plenary.nvim',
      'dharmx/telescope-media.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-smart-history.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',

      {
        'nvim-tree/nvim-web-devicons',
        enabled = vim.g.have_nerd_font,
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      local canned = require 'telescope._extensions.media.lib.canned'
      local data = assert(vim.fn.stdpath 'data') --[[@as string]]

      require('telescope').setup {
        defaults = {
          path_display = { 'smart' },
          sorting_strategy = 'ascending',
          layout_config = {
            prompt_position = 'top',
            horizontal = {
              width = 0.9,
              preview_width = 0.5,
            },
          },
          history = {
            path = vim.fs.joinpath(data, 'telescope_history.sqlite3'),
            limit = 100,
          },
          mappings = {
            n = {
              ['<c-d>'] = require('telescope.actions').delete_buffer,
              ['<M-p>'] = require('telescope.actions.layout').toggle_preview,
              ['<c-q>'] = require('telescope.actions').smart_send_to_loclist.action,
            },
            i = {
              ['<c-space>'] = 'to_fuzzy_refine',
              ['<c-d>'] = require('telescope.actions').delete_buffer,
              ['<M-p>'] = require('telescope.actions.layout').toggle_preview,
              ['<c-q>'] = require('telescope.actions').smart_send_to_loclist.action,
            },
          },
        },
        pickers = {
          find_files = {
            follow = true,
            hidden = true,
          },
        },

        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          media = {
            backend = 'chafa', -- image/gif backend
            flags = {
              chafa = {
                move = true, -- GIF preview
              },
            },
            on_confirm_single = canned.single.copy_path,
            on_confirm_muliple = canned.multiple.bulk_copy,
            cache_path = vim.fn.stdpath 'cache' .. '/media',

            -- backend = 'ueberzug',
            -- backend_options = {
            --   ueberzug = { xmove = -1, ymove = -1 },
            -- },
          },
          -- live_grep_args = {
          --   auto_quoting = true,
          --   -- Default arguments for live_grep_args
          --   vimgrep_arguments = {
          --     'rg',
          --     '--color=never',
          --     '--no-heading',
          --     '--with-filename',
          --     '--line-number',
          --     '--column',
          --     '--smart-case',
          --     '-u',
          --     '-L',
          --   },
          -- },
        },
      }
      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'media')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'live_grep_args')
      pcall(require('telescope').load_extension, 'remote-sshfs')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      local extensions = require('telescope').extensions
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      -- vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sg', extensions.live_grep_args.live_grep_args, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = '~/.config/nvim', follow = true }
      end, { desc = '[S]earch [N]eovim files' })

      -- Create the 'TelescopeGrepCurDir' command
      vim.api.nvim_create_user_command('TelescopeGrepCurDir', function()
        require('telescope.builtin').live_grep {
          search_dirs = { vim.fn.expand '%:p:h' },
        }
      end, { desc = "Live grep in current buffer's directory" })

      -- Create the 'TelescopeFindCurDir' command
      vim.api.nvim_create_user_command('TelescopeFindCurDir', function()
        require('telescope.builtin').find_files {
          search_dirs = { vim.fn.expand '%:p:h' },
        }
      end, { desc = "Find files in current buffer's directory" })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
