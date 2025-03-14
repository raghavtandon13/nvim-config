---@diagnostic disable: missing-fields

return {
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup { styles = { transparency = true } }
            vim.cmd 'colorscheme rose-pine-moon'
        end,
    },
    {
        'catppuccin/nvim',
        enabled = true,
        name = 'catppuccin',
        priority = 1000,
        config = function()
            require('catppuccin').setup { transparent_background = true, integrations = { gitsigns = false } }
            vim.cmd.colorscheme 'catppuccin-frappe'
        end,
    },
    {
        'folke/tokyonight.nvim',
        enabled = true,
        name = 'tokyonight',
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'tokyonight'
        end,
    },
    -- THIS IS THE BEST THEME EVER 
    {
        'sainnhe/gruvbox-material',
        enabled = false,
        config = function()
            vim.g.gruvbox_material_background = 'soft'
            vim.g.gruvbox_material_foreground = 'material'
            vim.g.gruvbox_material_transparent_background = 2
            vim.g.gruvbox_material_better_performance = 1
            vim.cmd.colorscheme 'gruvbox-material'
        end,
    },
}
