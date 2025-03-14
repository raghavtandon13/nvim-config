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
    {
        'dmmulroy/ts-error-translator.nvim',
        filetype = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'tsx', 'jsx' },
    },
    { 'echasnovski/mini.misc', version = '*', opts = {} },
    {
        'echasnovski/mini.move',
        event = 'VeryLazy',
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
    { 'echasnovski/mini.pairs', event = 'VeryLazy', version = '*', opts = {} },
    { 'echasnovski/mini.surround', event = 'VeryLazy', version = '*', opts = {} },
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {},
        keys = { {
            'x',
            mode = { 'n', 'x', 'o' },
            function()
                require('flash').jump()
            end,
            desc = 'flash',
        } },
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
                { filter = { event = 'msg_show', any = { { find = '^[^-]+-query-20[^-]+$' } } }, opts = { skip = true } },
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
        event = 'VeryLazy',
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
        event = 'VeryLazy',
        filetype = { 'html', 'javascriptreact', 'typescriptreact' },
        opts = { server = { override = false } },
        config = function()
            local cmp = require 'cmp'
            cmp.setup {
                formatting = {
                    format = require('lspkind').cmp_format { before = require('tailwind-tools.cmp').lspkind_format },
                },
            }
        end,
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
    { 'OXY2DEV/markview.nvim', filetype = { 'markdown', 'markdown_inline', 'Avante' }, opts = {} },
    {
        'rachartier/tiny-inline-diagnostic.nvim',
        event = 'VeryLazy',
        priority = 1000,
        config = function()
            require('tiny-inline-diagnostic').setup {
                preset = 'powerline',
                options = { multilines = { enabled = true, always_show = true }, show_all_diags_on_cursorline = true },
            }
            vim.diagnostic.config { virtual_text = false }
        end,
    },
    { 'saecki/crates.nvim', event = { 'BufRead Cargo.toml' }, opts = { completion = { cmp = { enabled = true } } } },
    { 'supermaven-inc/supermaven-nvim', event = { 'VeryLazy' }, opts = {} },
    {
        'tzachar/highlight-undo.nvim',
        event = 'VeryLazy',
        opts = {
            undo = { hlgroup = 'HighlightUndo', mode = 'n', lhs = 'u', map = 'undo' },
            redo = { hlgroup = 'HighlightRedo', mode = 'n', lhs = '<C-r>', map = 'redo' },
        },
    },
    { 'Wansmer/treesj', keys = { '<leader>m' }, event = 'VeryLazy', opts = { max_join_length = 20201120 } },
    {
        'yetone/avante.nvim',
        event = 'VeryLazy',
        version = false,
        opts = {
            provider = 'copilot',
            file_selector = { provider = 'telescope' },
            windows = {
                position = 'smart',
                wrap = true,
                width = 50,
                ask = { enabled = true },
                sidebar_header = { enabled = false },
            },
            behaviour = { enable_token_counting = false },
            hints = { enabled = false },
        },
        dependencies = { 'stevearc/dressing.nvim', 'zbirenbaum/copilot.lua', 'takeshid/avante-status.nvim' },
    },

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
