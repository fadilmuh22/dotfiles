return {
  { 'ThePrimeagen/git-worktree.nvim' },
  { 'sindrets/diffview.nvim' },
  { 'tpope/vim-abolish' },
  {
    'tpope/vim-fugitive',
    config = function()
      local function get_merge_base()
        local cmd = 'git merge-base origin HEAD'
        return vim.trim(vim.fn.system(cmd))
      end

      vim.keymap.set('n', '<leader>gg', '<cmd>Git<cr>', { desc = 'Fugitive' })
      vim.keymap.set('n', '<leader>gt', ':tab Git<CR>', { desc = 'Fugitive tab' })
      vim.keymap.set('n', '<leader>gv', ':vertical Git<CR>', { desc = 'Fugitive vertical' })
      vim.keymap.set('n', '<leader>gc', ':vertical Git log --patch %<CR>', { desc = 'Fugitive log current' })

      vim.keymap.set('n', '<leader>gr', function()
        vim.cmd('Git difftool -y ' .. get_merge_base())
      end, { desc = 'Fugitive difftool -y vs Base' })

      vim.keymap.set('n', '<leader>gf', function()
        vim.cmd('Git difftool --name-only ' .. get_merge_base())
      end, { desc = 'Fugitive changed files vs Base' })

      vim.keymap.set('n', '<leader>gD', function()
        vim.cmd('Gvdiffsplit! ' .. get_merge_base())
      end, { desc = 'Fugitive vertical Diff Split vs Base' })
    end,
  },
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })
        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
      end,
    },
  },
  {
    'harrisoncramer/gitlab.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'stevearc/dressing.nvim', -- Recommended but not required. Better UI for pickers.
      'nvim-tree/nvim-web-devicons', -- Recommended but not required. Icons in discussion tree.
    },
    build = function()
      require('gitlab.server').build(true)
    end, -- Builds the Go binary
    config = function()
      require('gitlab').setup()
    end,
  },
  {
    'ldelossa/gh.nvim',
    dependencies = {
      {
        'ldelossa/litee.nvim',
        config = function()
          require('litee.lib').setup()
        end,
      },
    },
    config = function()
      require('litee.gh').setup()
    end,
  },
}
