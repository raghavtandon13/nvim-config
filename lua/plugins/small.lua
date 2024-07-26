return {

    --[[ ENABLED ]]

    {
        'arsham/listish.nvim',
        dependencies = { 'arsham/arshlib.nvim', 'nvim-treesitter/nvim-treesitter-textobjects' },
        config = { signs = { qflist = '' }, extmarks = { qflist_text = 'Quickfix' } },
        keys = { '<leader>qq' },
        ft = { 'qf' },
    },
    {
        'cameron-wags/rainbow_csv.nvim',
        config = true,
        ft = { 'csv', 'tsv', 'csv_semicolon', 'csv_whitespace', 'csv_pipe', 'rfc_csv', 'rfc_semicolon' },
        cmd = { 'RainbowDelim', 'RainbowDelimSimple', 'RainbowDelimQuoted', 'RainbowMultiDelim' },
    },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = { 'MunifTanjim/nui.nvim' },
        opts = {
            cmdline = { enabled = true, view = 'cmdline' },
            lsp = { progress = { enabled = false }, hover = { enabled = false }, signature = { enabled = false } },
            routes = {
                { filter = { event = 'notify', find = 'No information available' }, opts = { skip = true } },
                { filter = { event = 'notify', find = 'Config Change Detected' }, opts = { skip = true } },
                { filter = { event = 'msg_show', any = { { find = 'fewer lines' } } }, opts = { skip = true } },
            },
            views = {
                mini = {
                    border = { style = 'rounded' },
                    win_options = { winblend = 0, winhighlight = { FloatBorder = 'Blue' } },
                    position = { row = -2 },
                },
            },
        },
    },
    { 'iamyoki/buffer-reopen.nvim', opts = {} },
    {
        'folke/todo-comments.nvim',
        event = 'BufReadPost',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = true, keywords = { NOTE = { icon = ' ', color = 'hint', alt = { 'todo' } } } },
    },
    { 'folke/trouble.nvim', opts = {} },
    {
        'folke/which-key.nvim',
        event = 'VimEnter',
        opts = {},
        config = function()
            require('which-key').setup { window = { border = 'single' } }
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
            require('which-key').register(
                { ['<leader>'] = { name = 'VISUAL <leader>' }, ['<leader>h'] = { 'Git [H]unk' } },
                { mode = 'v' }
            )
        end,
    },
    {
        'kdheepak/lazygit.nvim',
        cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
        keys = { { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' } },
    },
    {
        'laytan/tailwind-sorter.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
        build = 'cd formatter && npm ci && npm run build',
        config = true,
        opts = { on_save_enabled = true },
    },
    {
        'linrongbin16/lsp-progress.nvim',
        opts = {
            spinner = {
                '●∙∙',
                '∙●∙',
                '∙∙●',
                '∙●∙',
                '●∙∙',
                '∙●∙',
                '∙∙●',
                '∙●∙',
            },
            client_format = function(client_name, spinner, series_messages)
                return #series_messages > 0 and ('[' .. client_name .. '] ' .. spinner) or nil
            end,
            format = function(messages)
                if #messages > 0 then
                    return table.concat(messages)
                else
                    return ''
                end
            end,
        },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = { scope = { enabled = false } },
        event = 'BufReadPre',
    },
    { 'MeanderingProgrammer/markdown.nvim', opts = {} },
    { 'mg979/vim-visual-multi', branch = 'master', event = 'BufReadPre' },
    { 'mrjones2014/smart-splits.nvim', opts = {} },
    { 'MysticalDevil/inlay-hints.nvim', event = 'LspAttach', opts = { autocmd = { enable = false } } },
    { 'numToStr/Comment.nvim', opts = {}, event = 'BufReadPre' },
    { 'nvim-tree/nvim-web-devicons', opts = {} },
    { 'saecki/crates.nvim', event = { 'BufRead Cargo.toml' }, opts = {} },
    {
        'tzachar/highlight-undo.nvim',
        opts = {
            undo = { hlgroup = 'HighlightUndo', mode = 'n', lhs = 'u', map = 'undo' },
            redo = { hlgroup = 'HighlightRedo', mode = 'n', lhs = '<C-r>', map = 'redo' },
        },
    },
    {
        'Wansmer/treesj',
        keys = { '<leader>m' },
        event = 'BufReadPost',
        opts = { max_join_length = 20201120 },
    },

    --[[ DISABLED ]]

    { 'Exafunction/codeium.nvim', enabled = false, opts = {} },
    { 'MagicDuck/grug-far.nvim', enabled = false, opts = {} },
    { 'mbbill/undotree', enabled = false },
    { 'oysandvik94/curl.nvim', enabled = false, opts = {} },
    { 'ThePrimeagen/git-worktree.nvim', enabled = false, opts = {} },
    {
        'rcarriga/nvim-notify',
        enabled = false,
        opts = {
            background_colour = '#000000',
            timeout = 1000,
            top_down = false,
            stages = 'static',
            render = 'minimal',
        },
    },
}
