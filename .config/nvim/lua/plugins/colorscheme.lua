return {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.gruvbox_material_transparent_background = 1
        vim.o.background = "dark"  -- "dark" | "light"
        vim.g.gruvbox_material_foreground = "material" -- material | mix | original
        vim.g.gruvbox_material_background = "soft"  -- soft | medium | hard
        vim.g.gruvbox_material_ui_contrast = "high" -- low | high
        vim.g.gruvbox_material_float_style = "bright" -- bright | dim | none
        vim.g.gruvbox_material_statusline_style = "default" -- default | mix | original
        vim.g.gruvbox_material_cursor = "auto"
        vim.cmd.colorscheme("gruvbox-material")
    end
}
