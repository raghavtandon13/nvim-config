return {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
        {
            'x',
            mode = { 'n', 'x', 'o' },
            function()
                require('flash').jump()
            end,
            desc = 'Flash',
        },
    },
}
