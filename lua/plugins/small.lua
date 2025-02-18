---@diagnostic disable: missing-fields

return {

    --[[ ENABLED PLUGINS ]]

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
    { 'dmmulroy/ts-error-translator.nvim' },
    { 'echasnovski/mini.misc', version = '*', opts = {} },
    {
        'echasnovski/mini.move',
        version = '*',
        opts = {
            mappings = {
                left = '<C-M-left>',
                right = '<C-M-right>',
                down = '<C-M-down>',
                up = '<C-M-up>',
                line_left = '<C-M-left>',
                line_right = '<C-M-right>',
                line_down = '<C-M-down>',
                line_up = '<C-M-up>',
            },
        },
    },
    { 'echasnovski/mini.pairs', version = '*', opts = {} },
    { 'echasnovski/mini.surround', version = '*', opts = {} },
    {
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
                desc = 'flash',
            },
        },
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
                { filter = { event = 'notify', find = 'There were issues reported' }, opts = { skip = true } },
                { filter = { event = 'msg_show', any = { { find = 'fewer lines' } } }, opts = { skip = true } },
                { filter = { event = 'msg_show', any = { { find = '[supermaven-nvim]' } } }, opts = { skip = true } },
                {
                    filter = { event = 'msg_show', any = { { find = '^[^-]+-query-20[^-]+$' } } },
                    opts = { skip = true },
                },
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
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            indent = { scope = { enabled = true, animate = { enabled = false } } },
            notifier = { enabled = false },
            quickfile = { enabled = true },
            terminal = { enabled = true },
        },
    },
    {
        'folke/todo-comments.nvim',
        event = 'BufReadPost',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = true, keywords = { NOTE = { icon = ' ', color = 'hint', alt = { 'todo' } } } },
    },
    { 'folke/ts-comments.nvim', opts = {}, enabled = vim.fn.has 'nvim-0.10.0' == 1 },
    {
        'hat0uma/csvview.nvim',
        ft = { 'csv', 'tsv', 'csv_semicolon', 'csv_whitespace', 'csv_pipe', 'rfc_csv', 'rfc_semicolon' },
        config = function()
            require('csvview').setup { view = { display_mode = 'border' } }
            vim.cmd [[ CsvViewEnable ]]
        end,
    },
    { 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim', config = function() end },
    { 'iamyoki/buffer-reopen.nvim', opts = {} },
    { 'kevinhwang91/nvim-ufo', dependencies = { 'kevinhwang91/promise-async' } },
    {
        'kosayoda/nvim-lightbulb',
        config = function()
            require('nvim-lightbulb').setup {
                sign = { enabled = false },
                status_text = { enabled = true, text = '󱐋', text_unavailable = '' },
                autocmd = { enabled = true },
            }
        end,
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
        'luckasRanarison/tailwind-tools.nvim',
        filetype = { 'html', 'javascriptreact', 'typescriptreact' },
        opts = { server = { override = false } },
    },
    { 'mg979/vim-visual-multi', branch = 'master', event = 'BufReadPre' },
    {
        'michaelrommel/nvim-silicon',
        lazy = true,
        cmd = 'Silicon',
        main = 'nvim-silicon',
        opts = {
            line_offset = function(args)
                return args.line1
            end,
            font = 'Berkeley Mono',
        },
    },
    { 'mrjones2014/smart-splits.nvim', opts = {} },
    { 'MysticalDevil/inlay-hints.nvim', event = 'LspAttach', opts = { autocmd = { enable = false } } },
    { 'nvim-tree/nvim-web-devicons', opts = {} },
    {
        'OXY2DEV/markview.nvim',
        enabled = false,
        opts = {
            highlight_groups = {
                { group_name = 'Heading1', value = { fg = '#1e1e2e', bg = '#a6e3a1' } },
                { group_name = 'Heading1Corner', value = { fg = '#a6e3a1' } },
            },
            headings = {
                enable = true,
                shift_width = 0,
                heading_1 = {
                    style = 'label',
                    icon = '󰈙 ',
                    sign = ' ',
                    padding_left = ' ',
                    padding_right = ' ',
                    corner_right = '',
                    corner_right_hl = 'Heading1Corner',
                    hl = 'Heading1',
                },
            },
            inline_codes = { enable = true, hl = 'CursorLine' },
            code_blocks = { style = 'minimal', pad_amount = 3, pad_char = ' ', hl = 'CursorLine' },
        },
    },
    { 'saecki/crates.nvim', event = { 'BufRead Cargo.toml' }, opts = { completion = { cmp = { enabled = true } } } },
    {
        'supermaven-inc/supermaven-nvim',
        event = { 'InsertEnter' },
        config = function()
            require('supermaven-nvim').setup {}
        end,
    },
    {
        'tzachar/highlight-undo.nvim',
        opts = {
            undo = { hlgroup = 'HighlightUndo', mode = 'n', lhs = 'u', map = 'undo' },
            redo = { hlgroup = 'HighlightRedo', mode = 'n', lhs = '<C-r>', map = 'redo' },
        },
    },
    { 'Wansmer/treesj', keys = { '<leader>m' }, event = 'BufReadPost', opts = { max_join_length = 20201120 } },

    --[[ DISABLED PLUGINS ]]

    {
        'echasnovski/mini.indentscope',
        enabled = false,
        version = '*',
        config = function()
            require('mini.indentscope').setup {
                symbol = '|',
                draw = { animation = require('mini.indentscope').gen_animation.none() },
            }
        end,
    },
    { 'folke/trouble.nvim', enabled = false, opts = { pinned = true, focus = true } },
    {
        'lukas-reineke/indent-blankline.nvim',
        enabled = false,
        main = 'ibl',
        opts = {
            scope = { enabled = false },
            exclude = { filetypes = { 'text', 'markdown', 'yaml' } },
            indent = { char = '│' },
        },
        event = 'BufReadPre',
    },
    { 'mbbill/undotree', enabled = false },
    { 'mistweaverco/kulala.nvim', enabled = false, opts = {} },
    { 'numToStr/Comment.nvim', enabled = false, opts = {}, event = 'BufReadPre' },
    { 'ThePrimeagen/git-worktree.nvim', enabled = false, opts = {} },
    {
        'tpope/vim-dadbod',
        enabled = false,
        dependencies = { 'kristijanhusak/vim-dadbod-ui', 'kristijanhusak/vim-dadbod-completion' },
    },
}
