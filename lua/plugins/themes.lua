return {
    {
        'rose-pine/neovim',
        enabled = true,
        event = 'VimEnter',
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup({ styles = { transparency = true, italic = false } })
            vim.cmd('colorscheme rose-pine-main')
        end,
    },
}
