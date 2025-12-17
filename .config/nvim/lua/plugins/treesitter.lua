return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  opts = {
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
    ensure_installed = {
      "bash",
      "css",
      "dockerfile",
      "gitignore",
      "html",
      "javascript",
      "json",
      "jsonc",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "sql",
      "vim",
      "vimdoc",
      "yaml",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    additional_vim_regex_highlighting = false,
  },
}
