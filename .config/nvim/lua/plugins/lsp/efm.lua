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

    init_options = {
        documentFormatting = true,
    },

    settings = {
        languages = {
            python = {
                flake8,
                black,
            },

            sh = {
                shellcheck,
                shfmt,
            },

            solidity = {
                solhint,
                forge_fmt,
            },
        },
    },
})
