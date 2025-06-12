---@diagnostic disable: missing-fields

return {

    --[[ ENABLED PLUGINS ]]

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
        keys = { { 'x', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'flash' } },
    },
    {
        'smjonas/inc-rename.nvim',
        config = function() require('inc_rename').setup() end,
    },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = { 'MunifTanjim/nui.nvim' },
        opts = {
            cmdline = { enabled = true, view = 'cmdline' },
            routes = {
                { filter = { event = 'notify', find = 'No information available' }, opts = { skip = true } },
                { filter = { event = 'notify', find = 'Config Change Detected' }, opts = { skip = true } },
                { filter = { event = 'notify', find = 'There were issues reported' }, opts = { skip = true } },
                { filter = { event = 'msg_show', any = { { find = 'fewer lines' } } }, opts = { skip = true } },
                { filter = { event = 'msg_show', any = { { find = 'is deprecated' } } }, opts = { skip = true } },
                { filter = { event = 'msg_show', any = { { find = '[supermaven-nvim]' } } }, opts = { skip = true } },
                {
                    filter = { event = 'msg_show', any = { { find = '^[^-]+-query-20[^-]+$' } } },
                    opts = { skip = true },
                },
            },
            lsp = {
                progress = { enabled = false },
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true,
                },
            },
            presets = { long_message_to_split = true, inc_rename = true, lsp_doc_border = true },
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
            indent = { enabled = true, scope = { enabled = true, animate = { enabled = false } } },
            notifier = { enabled = false },
            quickfile = { enabled = true },
            terminal = { enabled = true },
            picker = {
                actions = {
                    toggle_live_case_sens = function(picker)
                        picker.opts.args = picker.opts.args or {}
                        picker.case_sens = picker.case_sens == nil and true or picker.case_sens
                        if picker.case_sens then
                            picker.opts.args = { '--case-sensetive' }
                        else
                            picker.opts.args = { '--ignore-case' }
                        end
                        picker.case_sens = not picker.case_sens
                        picker:find { refresh = true }
                    end,
                },
                win = {
                    input = {
                        keys = {
                            ['<F1>'] = { 'toggle_live_case_sens', mode = { 'i', 'n' } },
                            ['<C-x>'] = { 'edit_vsplit', mode = { 'i', 'n' } },
                            ['<C-d>'] = { 'bufdelete', mode = { 'i', 'n' } },
                        },
                    },
                },
            },
        },
    },
    {
        'folke/todo-comments.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = true, keywords = { NOTE = { icon = ' ', color = 'hint', alt = { 'todo' } } } },
    },
    {
        'folke/ts-comments.nvim',
        opts = {},
        enabled = vim.fn.has 'nvim-0.10.0' == 1,
    },
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
    {
        'kevinhwang91/nvim-ufo',
        dependencies = { 'kevinhwang91/promise-async' },
        config = function()
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (' 󰁂 %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, 'MoreMsg' })
                return newVirtText
            end
            require('ufo').setup { fold_virt_text_handler = handler }
        end,
    },
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
        opts = { disable_defaults = true, line_offset = function(args) return args.line1 end, font = 'Berkeley Mono' },
    },
    { 'mrjones2014/smart-splits.nvim', opts = {} },
    {
        'MysticalDevil/inlay-hints.nvim',
        event = 'LspAttach',
        opts = { autocmd = { enable = false } },
    },
    { 'nvim-tree/nvim-web-devicons', opts = {} },
    { 'OXY2DEV/markview.nvim', filetype = { 'markdown', 'markdown_inline', 'Avante', 'codecompanion' }, opts = {} },
    {
        'rachartier/tiny-inline-diagnostic.nvim',
        event = 'VimEnter',
        priority = 1000,
        config = function()
            require('tiny-inline-diagnostic').setup {
                preset = 'powerline',
                options = { multilines = { enabled = true, always_show = true }, show_all_diags_on_cursorline = true },
            }
            vim.diagnostic.config { virtual_text = false }
        end,
    },
    {
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        opts = { completion = { cmp = { enabled = true } } },
    },
    { 'supermaven-inc/supermaven-nvim', event = { 'VeryLazy' }, opts = {} },
    {
        'tzachar/highlight-undo.nvim',
        event = 'VeryLazy',
        opts = {
            undo = { hlgroup = 'HighlightUndo', mode = 'n', lhs = 'u', map = 'undo' },
            redo = { hlgroup = 'HighlightRedo', mode = 'n', lhs = '<C-r>', map = 'redo' },
        },
    },
    {
        'Wansmer/treesj',
        keys = { '<leader>m' },
        event = 'VeryLazy',
        opts = { max_join_length = 20201120 },
    },

    --[[ DISABLED PLUGINS ]]

    {
        'arsham/listish.nvim',
        enabled = false,
        dependencies = { 'arsham/arshlib.nvim', 'nvim-treesitter/nvim-treesitter-textobjects' },
        config = { signs = { qflist = '' }, extmarks = { qflist_text = 'Quickfix' } },
        keys = { '<leader>qq' },
        ft = { 'qf' },
    },
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
    { 'numToStr/Comment.nvim', enabled = false, opts = {}, event = 'BufReadPre' },
    { 'ThePrimeagen/git-worktree.nvim',  opts = {} },
}
