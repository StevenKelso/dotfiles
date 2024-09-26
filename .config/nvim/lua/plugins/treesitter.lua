return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = {
                "bash",
                "c",
                "css",
                "go",
                "html",
                "javascript",
                "lua",
                "python",
                "vim",
                "vimdoc",
                "markdown",
            },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
