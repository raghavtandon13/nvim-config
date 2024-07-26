return {
    {
        'echasnovski/mini.indentscope',
        version = '*',
        opts = { draw = {
            animation = function()
                return 0
            end,
        } },
    },
    {
        'echasnovski/mini.move',
        version = '*',
        opts = {
            mappings = {
                left = '<M-left>',
                right = '<M-right>',
                down = '<M-down>',
                up = '<M-up>',
                line_left = '<M-left>',
                line_right = '<M-right>',
                line_down = '<M-down>',
                line_up = '<M-up>',
            },
        },
    },
    { 'echasnovski/mini.misc', version = '*', opts = {} },
    { 'echasnovski/mini.pairs', version = '*', opts = {} },
    { 'echasnovski/mini.surround', version = '*', opts = {} },
}
