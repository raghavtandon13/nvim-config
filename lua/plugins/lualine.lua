local colors = {
    blue = '#80a0ff',
    cyan = '#79dac8',
    black = '#080808',
    white = '#c6c6c6',
    red = '#ff5189',
    violet = '#d183e8',
    ok1 = '#191724',
    ok = '#00FFFFFF',
    ok2 = '#332f4a',
    grey = '#303030',
    gruv1 = '#7fa678',
    gruv2 = '#a9b665',
    gruv3 = '#ea6962',
    orange = '#ff9e64',
    ccc = '#14141a'
}
local colors2 = {
    blue = '#80a0ff',
    cyan = '#79dac8',
    black = '#799dd9',
    white = '#c6c6c6',
    red = '#ff5189',
    violet = '#d183e8',
    ok1 = '#191724',
    ok = '#00FFFFFF',
    ok2 = '#332f4a',
    grey = '#303030',
    gruv1 = '#313244',
    gruv2 = '#a9b665',
    gruv3 = '#ea6962',
    orange = '#ff9e64',
}

local bubbles_theme = {
    normal = {
        a = { fg = colors2.black, bg = colors2.gruv1 },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.white, bg = colors.ccc },
        y = { fg = colors.white, bg = colors.black },
    },
    insert = { a = { fg = colors.black, bg = colors.gruv2 } },
    visual = { a = { fg = colors.black, bg = colors.gruv3 } },
    replace = { a = { fg = colors.black, bg = colors.red } },
    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.white },
    },
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
            -- theme = 'tokyonight', --  TODO: make a catppuccin bubbles theme
            component_separators = '|',
            section_separators = { left = '', right = '' },
            disabled_filetypes = { 'alpha' },
        },
        sections = {
            lualine_a = { { 'mode' } },
            lualine_b = {
                'branch',
                {
                    'diagnostics',
                    symbols = {
                        error = icons.diagnostics.Error,
                        warn = icons.diagnostics.Warn,
                        info = icons.diagnostics.Info,
                        hint = icons.diagnostics.Hint,
                    },
                },
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
                {
                    function()
                        local status = require('nvim-lightbulb').get_status_text()
                        return status
                    end,
                    color = { fg = '#ff9e64' },
                },
                {
                    function()
                        local str = require('noice').api.status.mode.get()
                        local match = str.match(str, 'recording @[A-Za-z]')
                        if match then
                            return match
                        end
                        return ''
                    end,
                    cond = require('noice').api.status.mode.has,
                    color = { fg = '#ff9e64' },
                },
            },
            lualine_c = {},
            lualine_x = {
                {
                    function()
                        local str = require('noice').api.status.search.get()
                        local match = 'Search: ' .. str.match(str, '%[%d+/%d+%]')
                        return match
                    end,
                    cond = require('noice').api.status.search.has,
                    color = { fg = '#ff9e64' },
                },
            },
            lualine_y = {
                function()
                    return require('lsp-progress').progress {}
                end,
            },
            lualine_z = { { 'buffers', symbols = { modified = ' ●', alternate_file = '', directory = '' } } },
        },
        extensions = { 'neo-tree', 'lazy', 'trouble', 'mason', 'fzf', 'fugitive' },
        refresh = { statusline = 1000 },
    },
}
