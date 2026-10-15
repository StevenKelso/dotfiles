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

local plugins = {
    "gruvbox-material",
    "indent-blankline.nvim",
    "mini.statusline",
    "nvim-autopairs",
    "mini.surround",
    "fzf-lua",
    "nvim-treesitter",
    "mason.nvim",
    "nvim-lspconfig",
    "efmls-configs-nvim",
}

for _, plugin in ipairs(plugins) do
    vim.cmd("packadd " .. plugin)
end

require("plugins.colorscheme")
require("plugins.indent-blankline")
require("plugins.statusline")
require("plugins.autopairs")
require("plugins.surround")
require("plugins.fzf-lua")
require("plugins.treesitter")
require("plugins.lsp")
