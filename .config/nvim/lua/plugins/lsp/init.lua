require("plugins.lsp.mason")
require("plugins.lsp.diagnostics")
require("plugins.lsp.attach")
require("plugins.lsp.servers")
require("plugins.lsp.efm")

vim.lsp.enable({
    "pyright",
    "bashls",
    "efm",
    "solidity_ls",
})
