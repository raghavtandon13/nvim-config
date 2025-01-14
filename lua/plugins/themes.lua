return {
    -- THIS IS THE BEST THEME EVER 
    {
        'sainnhe/gruvbox-material',
        enabled = true,
        config = function()
            vim.g.gruvbox_material_background = 'hard'
            vim.g.gruvbox_material_foreground = 'material'
            vim.g.gruvbox_material_transparent_background = 2
            vim.g.gruvbox_material_better_performance = 1
            vim.cmd.colorscheme 'gruvbox-material'
        end,
    },
}
