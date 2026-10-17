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
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup({
    scope = {
        enabled = false,
    },
    indent = {
        highlight = highlight,
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
        "lua",
        "markdown",
        "python",
        "solidity",
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
-- LSP, Linting, and Formatting
-- ============================================================================

-- mason
require("mason").setup({})

local diagnostic_signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = "",
}

-- Install these via :Mason
-- LSPs:
    -- pyright (python)
    -- bash-language-server (bash)
    -- vscode-solidity-server (solidity)
    -- efm (linter/formatter wrapper, see below)
-- Linters:
    -- flake8 (python)
    -- shellcheck (bash)
    -- solhint (solidity)
-- Formatters:
    -- black (python)
    -- shfmt (bash)
    -- forge_fmt (solidity: install with foundry, not mason)

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
        local params = vim.lsp.util.make_position_params()

        vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result)
            if err or not result or vim.tbl_isempty(result) then
                vim.notify("No definition found", vim.log.levels.WARN)
                return
            end

            local location = vim.islist(result) and result[1] or result

            local target_uri = location.uri or location.targetUri
            local current_uri = vim.uri_from_bufnr(0)

            if target_uri ~= current_uri then
                vim.notify("Definition is in another file", vim.log.levels.INFO)
                return
            end

            vim.lsp.util.show_document(location, "utf-8")
        end)
    end, opts)

    vim.keymap.set("n", "<leader>ft", function()
        require("fzf-lua").lsp_definitions({ jump1 = true })
    end, opts)

    vim.keymap.set("n", "<leader>fsv", function()
        vim.cmd("vsplit")
        vim.lsp.buf.definition()
    end, opts)

    vim.keymap.set("n", "<leader>fsh", function()
        vim.cmd("split")
        vim.lsp.buf.definition()
    end, opts)

    vim.keymap.set("n", "<leader>fr", function()
        require("fzf-lua").lsp_references()
    end, opts)
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>dq", function()
    vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })

vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("solidity_ls", {
    cmd = { "vscode-solidity-server", "--stdio" },
    filetypes = { "solidity" },
    root_dir = vim.fs.root(0, { ".git", "hardhat.config.js", "hardhat.config.ts", "foundry.toml" }),
})

do
    local flake8 = require("efmls-configs.linters.flake8")
    local black = require("efmls-configs.formatters.black")

    local shellcheck = require("efmls-configs.linters.shellcheck")
    local shfmt = require("efmls-configs.formatters.shfmt")

    local solhint = require("efmls-configs.linters.solhint")
    local forge_fmt = require("efmls-configs.formatters.forge_fmt")

    vim.lsp.config("efm", {
        filetypes = {
            "python",
            "sh",
            "solidity",
        },
        init_options = { documentFormatting = true },
        settings = {
            languages = {
                python = { flake8, black },
                sh = { shellcheck, shfmt },
                solidity = { solhint, forge_fmt },
            },
        },
    })
end

vim.lsp.enable({
    "pyright",
    "bashls",
    "efm",
    "solidity_ls",
})
