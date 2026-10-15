vim.lsp.config("pyright", {})

vim.lsp.config("bashls", {})

vim.lsp.config("solidity_ls", {
    cmd = {
        "vscode-solidity-server",
        "--stdio",
    },

    filetypes = {
        "solidity",
    },

    root_dir = vim.fs.root(0, {
        ".git",
        "hardhat.config.js",
        "hardhat.config.ts",
        "foundry.toml",
    }),
})
