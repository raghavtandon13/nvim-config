-- THEME
-- gruv1 =  voilet, gruv2 =  blue, gruv3 =  cyan
local colors = { blue = '#80a0ff', cyan = '#79dac8', black = '#080808', white = '#c6c6c6', red = '#ff5189', violet = '#d183e8', ok1 = '#191724', ok = '#00FFFFFF', ok2 = '#332f4a', grey = '#303030', gruv1 = '#a79984', gruv2 = '#a9b665', gruv3 = '#ea6962', orange = '#ff9e64' }
local bubbles_theme = {
    normal = { a = { fg = colors.black, bg = colors.gruv1 }, b = { fg = colors.white, bg = colors.black }, c = { fg = colors.white, bg = colors.ok } },
    insert = { a = { fg = colors.black, bg = colors.gruv2 } },
    visual = { a = { fg = colors.black, bg = colors.gruv3 } },
    replace = { a = { fg = colors.black, bg = colors.red } },
    inactive = { a = { fg = colors.white, bg = colors.black }, b = { fg = colors.white, bg = colors.black }, c = { fg = colors.white } },
}
local icons = {
    diagnostics = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' },
    git = { added = ' ', modified = ' ', removed = ' ' },
}

-- SETUP
return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            icons_enabled = true,
            theme = bubbles_theme,
            component_separators = '|',
            section_separators = { left = '', right = '' },
            disabled_filetypes = { 'alpha' },
        },
        sections = {
            lualine_a = { { 'mode' } },
            lualine_b = {
                'branch',
                { 'diagnostics', symbols = { error = icons.diagnostics.Error, warn = icons.diagnostics.Warn, info = icons.diagnostics.Info, hint = icons.diagnostics.Hint } },
                {
                    'diff',
                    symbols = { added = ' ', modified = icons.git.modified, removed = icons.git.removed },
                    source = function()
                        local gitsigns = vim.b.gitsigns_status_dict
                        if gitsigns then
                            return { added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed }
                        end
                    end,
                },
            },
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { { 'buffers', symbols = { modified = ' ●', alternate_file = '', directory = '' } } },
        },
        extensions = { 'neo-tree', 'lazy', 'trouble', 'mason', 'fzf', 'fugitive' },
    },
}
