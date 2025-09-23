return {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
        vim.o.background = "dark"  -- "dark" | "light"
        vim.g.gruvbox_material_palette = "material"  -- "material" | "mix" | "original"
        vim.g.gruvbox_material_background = "soft"  -- "soft" | "medium" | "hard"
        vim.g.gruvbox_material_enable_italic = true
        vim.g.gruvbox_material_transparent_background = 1 -- use terminal background
        vim.cmd.colorscheme('gruvbox-material')
    end
}
