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
vim.opt.tabline = ""

-- Misc
vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = "longest:full,full" -- complete longest match, full completion list, cycle through with tab

-- Netrw
vim.g.netrw_keepdir = 1
vim.g.netrw_fastbrowse = 0
vim.g.netrw_banner = 0 -- hide banner
vim.g.netrw_liststyle = 0 -- tree view
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25

-- ===========================================================
-- KEY MAPPINGS
-- ===========================================================

-- netrw
vim.keymap.set("n", "<leader>-", function()
	local bufname = vim.api.nvim_buf_get_name(0)
	local ft = vim.bo.filetype

	-- If we're in netrw, go back/close it
	if ft == "netrw" then
		vim.cmd("bd")
	else
		vim.cmd("Explore")
	end
end, { desc = "Toggle fullscreen netrw" })

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

-- window splitting
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<cr>", { desc = "close current split" })
vim.keymap.set("n", "<leader>se", "<c-w>=", { desc = "make splits equal size" })

-- window resizing
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Move lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- JSON formatting
vim.keymap.set("n", "<leader>jq", ":%!jq .<CR>", { desc = "format json expand" })

-- Tab navigation
vim.keymap.set("n", "<leader>to", ":$tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tn", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>tp", ":tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" })

-- Tab moving
vim.keymap.set("n", "<leader>tm", ":tabmove<CR>", { desc = "Move tab" })
vim.keymap.set("n", "<leader>t>", ":tabmove +1<CR>", { desc = "Move tab right" })
vim.keymap.set("n", "<leader>t<", ":tabmove -1<CR>", { desc = "Move tab left" })

-- ===========================================================
-- USEFUL FUNCTIONS
-- ===========================================================

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- format file
vim.keymap.set("n", "<leader>af", function()
    local buf = vim.api.nvim_get_current_buf()

    if vim.bo[buf].buftype ~= "" then return end
    if not vim.bo[buf].modifiable then return end
    if vim.api.nvim_buf_get_name(buf) == "" then return end

    local has_efm = false
    for _, c in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
        if c.name == "efm" then
            has_efm = true
            break
        end
    end
    if not has_efm then
        vim.notify("efm not attached to this buffer", vim.log.levels.WARN)
        return
    end

    pcall(vim.lsp.buf.format, {
        bufnr = buf,
        timeout_ms = 2000,
        filter = function(c) return c.name == "efm" end,
    })
end, { desc = "Format buffer (efm)" })


-- Copy Full File-Path
vim.keymap.set("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end)

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- wrap, linebreak and spellcheck for markdown and text files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = false
	end,
})

-- toggle diagnostics
vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

-- ===========================================================
-- PLUGINS (vim.pack)
-- ===========================================================

vim.pack.add({
	"https://github.com/sainnhe/gruvbox-material",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/nvim-mini/mini.statusline",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/nvim-mini/mini.surround",
	"https://github.com/ibhagwan/fzf-lua",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
	-- LSP
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/creativenull/efmls-configs-nvim",
})

local function packadd(name)
	vim.cmd("packadd " .. name)
end
packadd("gruvbox-material")
packadd("indent-blankline.nvim")
packadd("mini.statusline")
packadd("nvim-autopairs")
packadd("mini.surround")
packadd("fzf-lua")
packadd("nvim-treesitter")
-- LSP
packadd("mason.nvim")
packadd("nvim-lspconfig")
packadd("efmls-configs-nvim")

-- ===========================================================
-- PLUGIN CONFIGS
-- ===========================================================

-- gruvbox-material
vim.o.background = "dark" -- "dark" | "light"
vim.g.gruvbox_material_background = "hard" -- "soft" | "medium" | "hard"
vim.g.gruvbox_material_transparent_background = 2 -- 0 opaque | 1 transparent main | 2 transparent everything
vim.g.gruvbox_material_diagnostic_line_highlight = 1
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1
vim.cmd("colorscheme gruvbox-material")

-- indent-blankline
require("ibl").setup({
	scope = {
		enabled = false,
	},
})

-- mini.statusline
require("mini.statusline").setup()

-- nvim-autopairs
require("nvim-autopairs").setup({})

-- mini.surround
require("mini.surround").setup({})

-- fzf-lua
require("fzf-lua").setup({
	lsp = {
		jump1_action = FzfLua.actions.file_tabedit,
	},
})

vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "FZF Files" })

vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").live_grep({ cmd = "git grep --line-number --column --color=always" })
end, { desc = "FZF Live Grep" })

vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "FZF Buffers" })

vim.keymap.set("n", "<leader>fh", function()
	require("fzf-lua").help_tags()
end, { desc = "FZF Help Tags" })

-- nvim-treesitter
local setup_treesitter = function()
	local treesitter = require("nvim-treesitter")
	treesitter.setup({})
	local ensure_installed = {
		"bash",
		"css",
		"html",
		"json",
		"javascript",
		"lua",
		"markdown",
		"python",
		"rasi",
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

-- ============================================================================
-- LSP, Linting, Formatting & Completion
-- ============================================================================

-- mason
require("mason").setup({})

local diagnostic_signs = {
	Error = " ",
	Warn = " ",
	Hint = "",
	Info = "",
}

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig(contents, syntax, opts, ...)
	end
end

local function lsp_on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		return
	end

	local bufnr = ev.buf
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

	vim.keymap.set("n", "<leader>fd", function()
		require("fzf-lua").lsp_definitions({ jump1 = true })
	end, opts)

	vim.keymap.set("n", "<leader>fs", function()
		vim.cmd("vsplit")
		vim.lsp.buf.definition()
	end, opts)

	vim.keymap.set("n", "<leader>fr", function()
		require("fzf-lua").lsp_references()
	end, opts)

	vim.keymap.set("n", "<leader>ft", function()
		require("fzf-lua").lsp_typedefs()
	end, opts)
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>dq", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })

-- blink stuff goes here

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		},
	},
})
vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("gopls", {})
vim.lsp.config("solidity_ls", {
	cmd = { "vscode-solidity-server", "--stdio" },
	filetypes = { "solidity" },
	root_dir = vim.fs.root(0, { ".git", "hardhat.config.js", "hardhat.config.ts", "foundry.toml" }),
})

do
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")

	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")

	local eslint_d = require("efmls-configs.linters.eslint_d")
	local prettier_d = require("efmls-configs.formatters.prettier_d")

	local fixjson = require("efmls-configs.formatters.fixjson")

	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")

	local solhint = require("efmls-configs.linters.solhint")
	local forge_fmt = require("efmls-configs.formatters.forge_fmt")

	vim.lsp.config("efm", {
		filetypes = {
			"css",
			"html",
			"javascript",
			"json",
			"jsonc",
			"lua",
			"markdown",
			"python",
			"rust",
			"sh",
			"solidity",
			"typescript",
		},
		init_options = { documentFormatting = true },
		settings = {
			languages = {
				css = { prettier_d },
				html = { prettier_d },
				javascript = { eslint_d, prettier_d },
				json = { eslint_d, fixjson },
				jsonc = { eslint_d, fixjson },
				lua = { luacheck, stylua },
				markdown = { prettier_d },
				python = { flake8, black },
				sh = { shellcheck, shfmt },
				solidity = { solhint, forge_fmt },
				typescript = { eslint_d, prettier_d },
			},
		},
	})
end

vim.lsp.enable({
	"lua_ls",
	"pyright",
	"bashls",
	"ts_ls",
	"gopls",
	"efm",
	"solidity_ls",
})
