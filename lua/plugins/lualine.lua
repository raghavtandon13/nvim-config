---@diagnostic disable: missing-fields

local colors = {
    black = '#080808',
    white = '#c6c6c6',
    red = '#ff5189',
    ccc = '#14141a',
    black2 = '#799dd9',
    gruv1 = '#313244',
    gruv2 = '#a9b665',
    gruv3 = '#ea6962',
}

local bubbles_theme = {
    normal = {
        a = { fg = colors.black2, bg = colors.gruv1 },
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
            component_separators = '|',
            section_separators = { left = '', right = '' },
            disabled_filetypes = { 'alpha' },
        },
        sections = {
            lualine_a = { { 'mode' } },
            lualine_b = {
                'branch',
                {
                    function()
                        local spinner = require 'plugins.components.lualine_codecompanion_spinner'
                        return spinner:update_status() or ''
                    end,
                    color = { fg = '#ff9e64' },
                },
                {
                    function()
                        local spinner = require 'lualine_components.codecompanion_spinner'()
                        return spinner:update_status()
                    end,
                    color = { fg = '#ff9e64' },
                },
                {
                    function()
                        local r = pcall(require, 'mini.misc')
                            and require('mini.misc').find_root(
                                0,
                                { '.git', 'Makefile', '.root' },
                                function() return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h') end
                            )
                        return r and vim.fn.fnamemodify(r, ':t') or ''
                    end,
                    color = { fg = '#ff9e64', gui = 'italic' },
                },
                'selectioncount',
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
                        if match then return match end
                        return ''
                    end,
                    cond = require('noice').api.status.mode.has,
                    color = { fg = '#ff9e64' },
                },
            },
            lualine_c = {},
            lualine_x = { { 'searchcount', color = { fg = '#ff9e64' } } },
            lualine_y = { function() return require('lsp-progress').progress {} end },
            lualine_z = { { 'buffers', symbols = { modified = ' ●', alternate_file = '', directory = '' } } },
        },
        extensions = { 'neo-tree', 'lazy', 'trouble', 'mason', 'fzf', 'fugitive' },
        refresh = { statusline = 1000 },
    },
}
