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
vim.opt.tabline = ""

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
vim.keymap.set("n", "<leader>jq", ":%!jq .<CR>", { desc = "format json expand" })
-- vim.keymap.set('n', '<leader>jqm', ':%!jq -c .<CR>', { desc = 'format json minify' })

-- Tab navigation
vim.keymap.set("n", "<leader>to", ":$tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tO", ":$tabnew | Pick files<CR>", { desc = "New tab and fuzzy find" })
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

-- Format on save (ONLY real file buffers, ONLY when efm is attached)
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	pattern = {
		"*.lua",
		"*.py",
		"*.js",
		"*.json",
		"*.css",
		"*.html",
		"*.sh",
		"*.bash",
	},
	callback = function(args)
		-- avoid formatting non-file buffers (helps prevent weird write prompts)
		if vim.bo[args.buf].buftype ~= "" then
			return
		end
		if not vim.bo[args.buf].modifiable then
			return
		end
		if vim.api.nvim_buf_get_name(args.buf) == "" then
			return
		end

		local has_efm = false
		for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
			if c.name == "efm" then
				has_efm = true
				break
			end
		end
		if not has_efm then
			return
		end

		pcall(vim.lsp.buf.format, {
			bufnr = args.buf,
			timeout_ms = 2000,
			filter = function(c)
				return c.name == "efm"
			end,
		})
	end,
})

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

-- Function to duplicate current tab
local function duplicate_tab()
	local current_file = vim.fn.expand("%:p")
	if current_file ~= "" then
		vim.cmd("tabnew " .. current_file)
	else
		vim.cmd("tabnew")
	end
end
vim.keymap.set("n", "<leader>td", duplicate_tab, { desc = "Duplicate current tab" })

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

-- ===========================================================
-- PLUGINS (vim.pack)
-- ===========================================================

vim.pack.add({
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/otavioschwanck/arrow.nvim",
	"https://github.com/nvim-mini/mini.files",
	"https://github.com/nvim-mini/mini.statusline",
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
packadd("gruvbox.nvim")
packadd("indent-blankline.nvim")
packadd("nvim-autopairs")
packadd("arrow.nvim")
packadd("mini.files")
packadd("mini.statusline")
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
require("ibl").setup({
	scope = {
		enabled = false,
	},
})

-- nvim-autopairs
require("nvim-autopairs").setup({})

-- arrow
require("arrow").setup({
	show_icons = true,
	leader_key = ";", -- Recommended to be a single key
	buffer_leader_key = "m", -- Per Buffer Mappings
})

-- mini.files
require("mini.files").setup({
	mappings = {
		close = "-",
		go_in_plus = "l",
	},
})
vim.keymap.set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Open mini.files" })

-- mini.statusline
require("mini.statusline").setup({})

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
vim.keymap.set("n", "<leader>fx", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "FZF Diagnostics Workspace" })

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

	vim.keymap.set("n", "<leader>gd", function()
		require("fzf-lua").lsp_definitions({ jump1 = true })
	end, opts)

	vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, opts)

	vim.keymap.set("n", "<leader>gS", function()
		vim.cmd("vsplit")
		vim.lsp.buf.definition()
	end, opts)

	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	vim.keymap.set("n", "<leader>D", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, opts)
	vim.keymap.set("n", "<leader>d", function()
		vim.diagnostic.open_float({ scope = "cursor" })
	end, opts)
	vim.keymap.set("n", "<leader>nd", function()
		vim.diagnostic.jump({ count = 1 })
	end, opts)

	vim.keymap.set("n", "<leader>pd", function()
		vim.diagnostic.jump({ count = -1 })
	end, opts)

	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

	vim.keymap.set("n", "<leader>fd", function()
		require("fzf-lua").lsp_definitions({ jump1 = true })
	end, opts)
	vim.keymap.set("n", "<leader>fr", function()
		require("fzf-lua").lsp_references()
	end, opts)
	vim.keymap.set("n", "<leader>ft", function()
		require("fzf-lua").lsp_typedefs()
	end, opts)
	vim.keymap.set("n", "<leader>fs", function()
		require("fzf-lua").lsp_document_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fw", function()
		require("fzf-lua").lsp_workspace_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fi", function()
		require("fzf-lua").lsp_implementations()
	end, opts)

	if client:supports_method("textDocument/codeAction", bufnr) then
		vim.keymap.set("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
				bufnr = bufnr,
			})
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50)
		end, opts)
	end
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

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
