-- ===========================================================
-- OPTIONS
-- ===========================================================

-- Basic settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 30

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
-- vim.cmd.colorscheme("habamax")
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
vim.opt.iskeyword:append("-") -- include - in-words

-- Split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Tab display settings
vim.opt.showtabline = 2
vim.opt.tabline = ''

-- Misc
vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = "longest:full,full" -- complete longest match, full completion list, cycle through with tab


-- ===========================================================
-- KEY MAPPINGS
-- ===========================================================

-- better movement in wrapped text
vim.keymap.set("n", "j", function()
    return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })

vim.keymap.set("n", "k", function()
    return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

-- Y to EOL
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })

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

-- JSON formatting
vim.keymap.set('n', '<leader>jq', ':%!jq .<CR>', { desc = 'format json expand' })
-- vim.keymap.set('n', '<leader>jqm', ':%!jq -c .<CR>', { desc = 'format json minify' })

-- Tab navigation
vim.keymap.set('n', '<leader>to', ':$tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tO', ':$tabnew | Pick files<CR>', { desc = 'New tab and fuzzy find' })
vim.keymap.set('n', '<leader>tn', ':tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<leader>tp', ':tabprevious<CR>', { desc = 'Previous tab' })
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', { desc = 'Close tab' })

-- Tab moving
vim.keymap.set('n', '<leader>tm', ':tabmove<CR>', { desc = 'Move tab' })
vim.keymap.set('n', '<leader>t>', ':tabmove +1<CR>', { desc = 'Move tab right' })
vim.keymap.set('n', '<leader>t<', ':tabmove -1<CR>', { desc = 'Move tab left' })


-- ===========================================================
-- USEFUL FUNCTIONS
-- ===========================================================

-- Copy Full File-Path
vim.keymap.set("n", "<leader>pa", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("file:", path)
end)

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Function to duplicate current tab
local function duplicate_tab()
    local current_file = vim.fn.expand('%:p')
    if current_file ~= '' then
        vim.cmd('tabnew ' .. current_file)
    else
        vim.cmd('tabnew')
    end
end
vim.keymap.set('n', '<leader>td', duplicate_tab, { desc = 'Duplicate current tab' })

-- wrap, linebreak and spellcheck on markdown and text files
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "markdown", "text", "gitcommit" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
    end,
})


-- ===========================================================
-- PLUGINS (vim.pack)
-- ===========================================================

vim.pack.add({
    "https://github.com/ellisonleao/gruvbox.nvim",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/otavioschwanck/arrow.nvim",
    "https://github.com/nvim-tree/nvim-tree.lua",
    "https://github.com/nvim-mini/mini.statusline",
    "https://github.com/nvim-mini/mini.surround",
    "https://github.com/nvim-mini/mini.pick",
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
    },
})

local function packadd(name)
    vim.cmd("packadd " .. name)
end
packadd("gruvbox.nvim")
packadd("indent-blankline.nvim")
packadd("nvim-autopairs")
packadd("arrow.nvim")
packadd("nvim-tree.lua")
packadd("mini.statusline")
packadd("mini.surround")
packadd("mini.pick")
packadd("nvim-treesitter")


-- ===========================================================
-- PLUGIN CONFIGS
-- ===========================================================

-- gruvbox
require("gruvbox").setup({
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "hard", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")

-- indent-blankline
require("ibl").setup({})

-- nvim-autopairs
require("nvim-autopairs").setup({})

-- arrow
require('arrow').setup({
    show_icons = true,
    leader_key = ';', -- Recommended to be a single key
    buffer_leader_key = 'm', -- Per Buffer Mappings
})

-- nvim-tree
require("nvim-tree").setup({
    view = {
        width = 45,
    },
    filters = {
        dotfiles = false,
        git_ignored = false,
    },
    renderer = {
        group_empty = true,
    },
})
vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>", { desc = "Toggle Nvim-Tree" })

-- mini.statusline
require('mini.statusline').setup({})

-- mini.surround
require('mini.surround').setup({})

-- mini.pick
require('mini.pick').setup({})
vim.keymap.set("n", "<leader>ff", function() MiniPick.builtin.files({}) end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function() MiniPick.builtin.grep_live({}) end, { desc = "Grep (search in files)" })

-- nvim-treesitter
local setup_treesitter = function()
    local treesitter = require("nvim-treesitter")
    treesitter.setup({})
    local ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "go",
        "html",
        "json",
        "jsonc",
        "javascript",
        "lua",
        "markdown",
        "python",
        "rust",
        "solidity",
        "typescript",
        "vim",
        "vimdoc",
    }

    local config = require("nvim-treesitter.config")

    local already_installed = config.get_installed()
    local parsers_to_install = {}

    for _, parser in ipairs(ensure_installed) do
        if not vim.tbl_contains(already_installed, parser) then
            table.insert(parsers_to_install, parser)
        end
    end

    if #parsers_to_install > 0 then
        treesitter.install(parsers_to_install)
    end

    local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(args)
            if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
                vim.treesitter.start(args.buf)
            end
        end,
    })
end

setup_treesitter()


