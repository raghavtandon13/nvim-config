return {
    {
        'rose-pine/neovim',
        enabled = true,
        event = 'VimEnter',
        name = 'rose-pine',
        config = function()
            if vim.g.neovide then
                require('rose-pine').setup({})
            else
                require('rose-pine').setup({ styles = { transparency = true } })
            end
            vim.cmd('colorscheme rose-pine-main')
        end,
    },
}
