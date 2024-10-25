-- set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- set highlight on search
vim.o.hlsearch = true

-- set relative and absolute line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- enable break indent
vim.o.breakindent = true

-- no swap files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- NOTE: make sure your terminal supports this
vim.o.termguicolors = true

-- open splits on the right and below
vim.opt.splitbelow = true
vim.opt.splitright = true

-- set tabs as spaces
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- always use spaces insted of tabs
vim.opt.expandtab = true

-- don't wrap lines
vim.opt.wrap = true
-- wrap lines at convenient points
vim.opt.linebreak = true
-- show line breaks
vim.opt.showbreak = "↳"

-- start scrolling when 8 lines aways from border
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 5

-- set color column
vim.opt.colorcolumn = "80"
