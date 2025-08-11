set number
set relativenumber

set shiftwidth=4       " number of spaces to use for each indentation
set softtabstop=4      " number of spaces a <tab> counts for while editing
set expandtab          " use spaces instead of tabs
set smartindent        " automatically inserts one extra level of indentation

" Optional usability improvements
set autoindent         " Copy indent from current line when starting a new one
set tabstop=4          " Number of spaces that a <Tab> in the file counts for
set mouse=a            " Enable mouse support
syntax on              " Enable syntax highlighting
filetype plugin indent on  " Enable filetype-based indentation and plugins

let mapleader = " "
vnoremap <leader>y "+y

