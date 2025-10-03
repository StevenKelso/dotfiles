-- set leader key to space
vim.g.mapleader = " "

-- for conciseness
local keymap = vim.keymap

-- move lines in visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

-- center screen while searching
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<cr>", { desc = "clear search hl", silent = true })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- window management
keymap.set("n", "<leader>sv", "<c-w>v", { desc = "split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<c-w>s", { desc = "split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<c-w>=", { desc = "make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<cr>", { desc = "close current split" }) -- close current split window
