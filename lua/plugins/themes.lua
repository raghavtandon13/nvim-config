return {
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        opts = { style = 'night', transparent = true, lualine_bold = true },
        config = function()
            require('tokyonight').setup {
                on_highlights = function(hl, c)
                    local prompt = ''
                    hl.TelescopeNormal = { bg = prompt, fg = c.fg_dark }
                    hl.TelescopeBorder = { bg = prompt }
                    hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
                    hl.TelescopePromptTitle = { bg = prompt }
                end,
            }
            vim.cmd.colorscheme 'tokyonight'
        end,
    },
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
    {
        'sho-87/kanagawa-paper.nvim',
        enabled = false,
        config = function()
            require('kanagawa-paper').setup {
                transparent = true,
                colors = { theme = { ui = { float = { bg = '' } } } },
            }
            vim.cmd.colorscheme 'kanagawa-paper'
        end,
    },
}
