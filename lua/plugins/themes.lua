return {
    {
        'AlexvZyl/nordic.nvim',
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            require('nordic').setup { transparent_bg = true }
            vim.cmd.colorscheme 'nordic'
        end,
    },
    {
        'catppuccin/nvim',
        enabled = false,
        name = 'catppuccin',
        priority = 1000,
        config = function()
            require('catppuccin').setup { transparent_background = true, default_integrations = false }
            vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = '#2a2b3c' })
            vim.cmd.colorscheme 'catppuccin-mocha'
        end,
    },
    {
        'rose-pine/neovim',
        enabled = false,
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup { styles = { bold = false, italic = true, transparency = true } }
            vim.cmd.colorscheme 'rose-pine'
        end,
        lazy = false,
        priority = 1000,
    },
    {
        'sainnhe/gruvbox-material',
        enabled = true,
        config = function()
            vim.g.gruvbox_material_background = 'hard'
            vim.g.gruvbox_material_foreground = 'material'
            vim.g.gruvbox_material_transparent_background = 2
            vim.cmd.colorscheme 'gruvbox-material'
        end,
    },
    {
        'sainnhe/sonokai',
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.sonokai_enable_italic = true
            vim.g.sonokai_transparent_background = true
            vim.cmd.colorscheme 'sonokai'
        end,
    },
    {
        'sho-87/kanagawa-paper.nvim',
        enabled = false,
        config = function()
            require('kanagawa-paper').setup { transparent = true, colors = { theme = { ui = { float = { bg = '' } } } } }
            vim.cmd.colorscheme 'kanagawa-paper'
        end,
    },
}
