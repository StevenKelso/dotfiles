vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- open vim explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- save
vim.keymap.set("n", "<Leader>s", ":write<CR>", { silent = true })

-- quit
vim.keymap.set("n", "Q", "<C-W>q")

-- make splits
vim.keymap.set("n", "vv", "<C-W>v")
vim.keymap.set("n", "ss", "<C-W>s")

-- jump between splits
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- indenting in visual mode (tab/shift+tab)
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- Move to the end of yanked text after yank and paste
vim.cmd("vnoremap <silent> y y`]")
vim.cmd("vnoremap <silent> p p`]")
vim.cmd("nnoremap <silent> p p`]")

-- clear search highlight
vim.keymap.set("n", "<Leader>l", ":noh<CR>", { silent = true })
