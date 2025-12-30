return {
    {
        'nvim-mini/mini.pick',
        opts = {},
        vim.keymap.set('n', '<Leader>ff', function() MiniPick.builtin.files({ tool = 'git'}) end, { desc = 'Find Files' }),
        vim.keymap.set('n', '<Leader>fg', function() MiniPick.builtin.grep_live({ tool = 'git'}) end, { desc = 'Grep (search in files)' }),
    }
}
