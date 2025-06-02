vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.g.vimtex_compiler_latexmk = {
  out_dir = 'build',
}

require 'options'

require 'keymaps'

require 'lazy-bootstrap'

require 'lazy-plugins'
