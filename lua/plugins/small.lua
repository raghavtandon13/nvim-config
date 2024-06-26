return {

    --[[ ENABLED ]]

    { 'arsham/listish.nvim', dependencies = { 'arsham/arshlib.nvim', 'nvim-treesitter/nvim-treesitter-textobjects' }, config = { signs = { qflist = '' }, extmarks = { qflist_text = 'Quickfix' } }, keys = { '<leader>qq' }, ft = { 'qf' } },
    { 'folke/noice.nvim', event = 'VeryLazy', dependencies = { 'MunifTanjim/nui.nvim' }, opts = { routes = { { filter = { event = 'notify', find = 'No information available' }, opts = { skip = true } } }, cmdline = { enabled = true, view = 'cmdline' }, views = { mini = { win_options = { winblend = 0 } } }, lsp = { hover = { enabled = false }, signature = { enabled = false } } } },
    { 'folke/todo-comments.nvim', event = 'BufReadPost', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = true, keywords = { NOTE = { icon = ' ', color = 'hint', alt = { 'todo' } } } } },
    { 'folke/trouble.nvim', opts = {} },
    { 'kdheepak/lazygit.nvim', cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' }, keys = { { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' } } },
    { 'laytan/tailwind-sorter.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' }, build = 'cd formatter && npm ci && npm run build', config = true, opts = { on_save_enabled = true } },
    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = { scope = { enabled = false } }, event = 'BufReadPre' },
    { 'MeanderingProgrammer/markdown.nvim', opts = {}, event = 'BufReadPost' },
    { 'mg979/vim-visual-multi', branch = 'master', event = 'BufReadPre' },
    { 'numToStr/Comment.nvim', opts = {}, event = 'BufReadPre' },
    { 'nvim-tree/nvim-web-devicons', opts = {} },
    { 'tzachar/highlight-undo.nvim', opts = { undo = { hlgroup = 'HighlightUndo', mode = 'n', lhs = 'u', map = 'undo' }, redo = { hlgroup = 'HighlightRedo', mode = 'n', lhs = '<C-r>', map = 'redo' } } },
    { 'Wansmer/treesj', keys = { '<leader>m' }, event = 'BufReadPost', opts = { max_join_length = 1120 } },
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
    { 'MagicDuck/grug-far.nvim', enabled = false, opts = {} },
    { 'mbbill/undotree', enabled = false },
    { 'rcarriga/nvim-notify', enabled = false, opts = { background_colour = '#000000', timeout = 1000, top_down = false, stages = 'static', render = 'minimal' } },
    { 'ThePrimeagen/git-worktree.nvim', enabled = false, opts = {} },
}
