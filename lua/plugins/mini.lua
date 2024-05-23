return {
    {
        'echasnovski/mini.misc',
        version = '*',
        config = function()
            require('mini.misc').setup()
        end,
    },
    { 'echasnovski/mini.surround', version = '*', opts = {} },
    {
        'echasnovski/mini.move',
        version = '*',
        config = function()
            require('mini.move').setup {
                mappings = {
                    -- Move visual selection in Visual mode.
                    left = '<M-left>',
                    right = '<M-right>',
                    down = '<M-down>',
                    up = '<M-up>',

                    -- Move current line in Normal mode.
                    line_left = '<M-left>',
                    line_right = '<M-right>',
                    line_down = '<M-down>',
                    line_up = '<M-up>',
                },
            }
        end,
    },
    {
        'echasnovski/mini.indentscope',
        version = '*',
        opts = {
            draw = { draw = {
                animation = function()
                    return 0
                end,
            } },
            options = {
                try_as_border = true,
            },
        },
    },
}
