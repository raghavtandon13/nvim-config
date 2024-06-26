return {
    {
        'echasnovski/mini.indentscope',
        event = { 'BufReadPost', 'BufNewFile' },
        version = '*',
        opts = { draw = {
            animation = function()
                return 0
            end,
        } },
    },
    {
        'echasnovski/mini.move',
        event = { 'BufReadPost', 'BufNewFile' },
        version = '*',
        config = function()
            require('mini.move').setup { mappings = { left = '<M-left>', right = '<M-right>', down = '<M-down>', up = '<M-up>', line_left = '<M-left>', line_right = '<M-right>', line_down = '<M-down>', line_up = '<M-up>' } }
        end,
    },
    { 'echasnovski/mini.misc', version = '*', event = { 'BufReadPost', 'BufNewFile' }, opts = {} },
    { 'echasnovski/mini.pairs', version = '*', opts = {} },
    { 'echasnovski/mini.surround', version = '*', opts = {}, event = { 'BufReadPost', 'BufNewFile' } },
}
