-- CodeCompanion with my changes
return {
    'olimorris/codecompanion.nvim',
    -- 'raghavtandon13/codecompanion.nvim',
    event = 'VeryLazy',
    opts = {
        strategies = { chat = { slash_commands = { ['file'] = { opts = { provider = 'snacks' } } } } },
        display = {
            action_palette = { provider = 'snacks' },
            diff = { provider = 'mini_diff' },
            chat = { show_header_separator = true, show_token_count = false },
        },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        { 'nvim-lualine/lualine.nvim', otps = {} },
        {
            'echasnovski/mini.diff',
            version = '*',
            opts = { view = { style = 'sign', signs = { add = '+', change = '~', delete = '_' } } },
        },
    },
    init = function() require('plugins.components.lualine_codecompanion_spinner'):init() end,
}
