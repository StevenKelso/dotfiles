" basic settings
let mapleader=" "
set number
set relativenumber
set scrolloff=10
set sidescrolloff=30

" colors
colorscheme retrobox
set t_ut=

" indenting
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set autoindent

" searching
set ignorecase
set smartcase
set hlsearch
set incsearch
nnoremap <leader>c :nohlsearch<CR>

" enable syntax highlighting
syntax on

" enable mouse support
set mouse=a

" disable swap files
set noswapfile

" clear search highlighting quickly
nnoremap <leader>c :nohlsearch<CR>

" splitting
nnoremap <leader>sv :vsplit<CR>
nnoremap <leader>sh :split<CR>
nnoremap <leader>sx <cmd>close<cr>

" easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
