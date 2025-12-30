-- Key mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Visual settings
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = false
vim.opt.pumheight = 10

-- File handling
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Behavior settings
vim.opt.backspace = "indent,eol,start"

-- Split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Normal mode mappings
vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })
vim.keymap.set("n", "G", "Gzz", { desc = "Clear search highlights" })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x')

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Splitting & Resizing
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<cr>", { desc = "close current split" })
vim.keymap.set("n", "<leader>se", "<c-w>=", { desc = "make splits equal size" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })


-- ============================================================================
-- USEFUL FUNCTIONS
-- ============================================================================

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.highlight.on_yank()
    end,
})


-- ============================================================================
-- TABS
-- ============================================================================

-- Tab display settings
vim.opt.showtabline = 2
vim.opt.tabline = ''

-- Transparent tabline appearance
vim.cmd([[
hi TabLineFill guibg=NONE ctermfg=242 ctermbg=NONE
]])

-- Alternative navigation (more intuitive)
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tn', ':tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<leader>tp', ':tabprevious<CR>', { desc = 'Previous tab' })
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', { desc = 'Close tab' })

-- Tab moving
vim.keymap.set('n', '<leader>tm', ':tabmove<CR>', { desc = 'Move tab' })
vim.keymap.set('n', '<leader>t>', ':tabmove +1<CR>', { desc = 'Move tab right' })
vim.keymap.set('n', '<leader>t<', ':tabmove -1<CR>', { desc = 'Move tab left' })


-- ============================================================================
-- PLUGINS
-- ============================================================================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- gruvbox-material
        {
            "sainnhe/gruvbox-material",
            lazy = false,
            config = function()
                vim.g.gruvbox_material_transparent_background = 1
                vim.o.background = "dark" -- dark | light
                vim.g.gruvbox_material_foreground = "material" -- material | mix | original
                vim.g.gruvbox_material_background = "soft" -- soft | medium | hard
                vim.g.gruvbox_material_ui_contrast = "high" -- low | high
                vim.g.gruvbox_material_float_style = "bright" -- bright | dim | blend
                vim.g.gruvbox_material_statusline_style = "default" -- default | mix | original
                vim.g.gruvbox_material_cursor = "auto"
                vim.cmd.colorscheme('gruvbox-material')
            end
        },

        -- indent-blankline
        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
            opts = {
                scope = {
                    enabled = false
                },
            },
        },

        -- oil
        {
            "stevearc/oil.nvim",
            opts = {
                view_options = {
                    show_hidden = true,
                }
            },
            dependencies = { { "nvim-mini/mini.icons", opts = {} } },
            lazy = false,
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),
        },

        -- mini.statusline
        {
            "nvim-mini/mini.statusline",
            opts = {},
        },

        -- mini.pairs
        {
            "nvim-mini/mini.pairs",
            opts = {},
        },

        -- mini.surround
        {
            "nvim-mini/mini.surround",
            opts = {},
        },

        -- mini.pick
        {
            "nvim-mini/mini.pick",
            opts = {},
            vim.keymap.set("n", "<leader>ff", function() MiniPick.builtin.files({ tool = "git" }) end, { desc = "Find Files" }),
            vim.keymap.set("n", "<leader>fg", function() MiniPick.builtin.grep_live({ tool = "git" }) end, { desc = "Grep (search in files)" }),
        },
    }
})


require('mini.statusline').setup()
require('mini.pairs').setup()
require('mini.surround').setup()
require('mini.pick').setup()
