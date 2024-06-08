return {

    --[[ ENABLED ]]

    { 'MeanderingProgrammer/markdown.nvim', opts = {}, event = 'BufReadPost' },
    { 'ThePrimeagen/git-worktree.nvim', enabled = false, opts = {} },
    { 'Wansmer/treesj', keys = { '<leader>m' }, event = 'BufReadPost', opts = { max_join_length = 1120 } },
    { 'arsham/listish.nvim', dependencies = { 'arsham/arshlib.nvim', 'nvim-treesitter/nvim-treesitter-textobjects' }, config = { signs = { qflist = '' }, extmarks = { qflist_text = 'Quickfix' } }, keys = { '<leader>qq' }, ft = { 'qf' } },
    { 'folke/noice.nvim', event = 'VeryLazy', dependencies = { 'MunifTanjim/nui.nvim' }, opts = { routes = { { filter = { event = 'notify', find = 'No information available' }, opts = { skip = true } } }, cmdline = { enabled = true, view = 'cmdline' }, views = { mini = { win_options = { winblend = 0 } } }, lsp = { hover = { enabled = false }, signature = { enabled = false } } } },
    { 'folke/todo-comments.nvim', event = 'BufReadPost', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = true, keywords = { NOTE = { icon = ' ', color = 'hint', alt = { 'todo' } } } } },
    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = { scope = { enabled = false } }, event = 'BufReadPre' },
    { 'mg979/vim-visual-multi', branch = 'master', event = 'BufReadPre' },
    { 'numToStr/Comment.nvim', opts = {}, event = 'BufReadPre' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-rhubarb' },
    { 'tpope/vim-sleuth' },
    { 'windwp/nvim-autopairs', event = 'InsertEnter' },
    {
        'folke/which-key.nvim',
        event = 'VimEnter',
        opts = {},
        config = function()
            require('which-key').setup { window = { border = 'single' } }
            require('which-key').register { ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' }, ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' }, ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' }, ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' }, ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' }, ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' }, ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' }, ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' } }
            require('which-key').register({ ['<leader>'] = { name = 'VISUAL <leader>' }, ['<leader>h'] = { 'Git [H]unk' } }, { mode = 'v' })
        end,
    },

    --[[ DISABLED ]]

    { 'Exafunction/codeium.nvim', enabled = false, opts = {} },
    { 'NeogitOrg/neogit', enabled = false, dependencies = { 'sindrets/diffview.nvim' }, event = 'BufReadPre', config = true },
    { 'folke/trouble.nvim', enabled = true, opts = {} },
    { 'mbbill/undotree', enabled = false },
    { 'rcarriga/nvim-notify', enabled = false, opts = { background_colour = '#000000', timeout = 1000, top_down = false, stages = 'static', render = 'minimal' } },
    {
        'kdheepak/lazygit.nvim',
        enabled = false,
        cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').load_extension 'lazygit'
        end,
        keys = { { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' } },
    },
}
