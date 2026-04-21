" leader key
let mapleader=" "

" colorscheme
colorscheme retrobox

" line numbering
set number
set relativenumber

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

" enable syntax highlighting
syntax on

" enable mouse support
set mouse=a

" disable swap files
set noswapfile

" clear search highlighting quickly
nnoremap <leader>c :nohlsearch<CR>

" basic keymaps
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" splitting
nnoremap <leader>sv :vsplit<CR>
nnoremap <leader>sh :split<CR>
nnoremap <leader>sx <cmd>close<cr>

" easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
