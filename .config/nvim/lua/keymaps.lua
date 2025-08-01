-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Buffers keymaps
vim.keymap.set('n', '<leader>d', '"_d', { noremap = true, desc = '[D]elete not cut' })
vim.keymap.set('n', '<leader>bd', ':bd<CR>')
vim.keymap.set('n', '<leader>bo', '<cmd>%bd|e#<cr>', { desc = 'Close all buffers but the current one' }) -- https://stackoverflow.com/a/42071865/516188

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set('n', '+', [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
vim.keymap.set('n', '_', [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically
vim.keymap.set('n', '=', [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
vim.keymap.set('n', '-', [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -

-- Global state to track the diagnostic float window
-- _G.diagnostic_float_win = nil

-- vim.keymap.set('n', '<C-w><C-d>', function()
--   -- If float window exists and is still valid, focus it
--   if _G.diagnostic_float_win and vim.api.nvim_win_is_valid(_G.diagnostic_float_win) then
--     vim.api.nvim_set_current_win(_G.diagnostic_float_win)
--     return
--   end
--
--   -- Otherwise, open a new diagnostic float and store its window ID
--   local opts = {
--     border = 'rounded',
--     max_width = 80,
--     focusable = true,
--   }
--
--   local _bufnr, winnr = vim.diagnostic.open_float(nil, opts)
--   if winnr then
--     _G.diagnostic_float_win = winnr
--   end
-- end, { noremap = true, silent = true, desc = 'Toggle diagnostic float and focus' })

vim.keymap.set('n', '<leader>cp', function()
  local filepath = vim.api.nvim_buf_get_name(0)
  local root = vim.fn.system('git rev-parse --show-toplevel'):gsub('\n', '')
  local relpath = filepath:sub(#root + 2)
  local row = vim.fn.line '.'
  local col = vim.fn.col '.'
  local final = string.format('%s:%d:%d', relpath, row, col)
  vim.fn.setreg('+', final)
  print('Copied: ' .. final)
end, { desc = 'Copy file path from project root with line & col' })

-- vim: ts=2 sts=2 sw=2 et
