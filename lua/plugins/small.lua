return {
    { 'Exafunction/codeium.nvim', opts = {} },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-rhubarb' },
    { 'tpope/vim-sleuth' },
    { 'mg979/vim-visual-multi', branch = 'master' },
    { 'mbbill/undotree' },
    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
    { 'numToStr/Comment.nvim', opts = {} },
    { 'famiu/bufdelete.nvim' },
    { 'kevinhwang91/nvim-ufo' },
    { 'folke/trouble.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, opts = {} },
    { 'windwp/nvim-autopairs', event = 'InsertEnter' },
    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
    { 'Wansmer/treesj', keys = { '<leader>m' }, opts = {} },
    { 'MeanderingProgrammer/markdown.nvim', opts = {} },
    {
        'folke/which-key.nvim',
        event = 'VimEnter',
        opts = {},
        config = function()
            require('which-key').register {
                ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
                ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
                ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
                ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
                ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
                ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
                ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
                ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
            }
            require('which-key').register({
                ['<leader>'] = { name = 'VISUAL <leader>' },
                ['<leader>h'] = { 'Git [H]unk' },
            }, { mode = 'v' })
        end,
    },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        opts = {
            cmdline = { enabled = true, view = 'cmdline' },
            views = { mini = { win_options = { winblend = 0 } } },
        },
        dependencies = { 'MunifTanjim/nui.nvim' },
    },
    {
        'kdheepak/lazygit.nvim',
        cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').load_extension 'lazygit'
        end,
        keys = { { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' } },
    },
}
