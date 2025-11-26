return {
    {
        'stevearc/conform.nvim',
        event = 'VeryLazy',
        config = function()
            require('conform').setup {
                notify_on_error = false,
                formatters_by_ft = {
                    c = { 'clang-format' },
                    cpp = { 'clang-format' },
                    css = { 'prettierd' },
                    go = { 'gofumpt' },
                    html = { 'prettierd' },
                    javascript = { 'prettierd' },
                    javascriptreact = { 'prettierd' },
                    json = { 'prettierd' },
                    lua = { 'stylua' },
                    markdown = { 'prettierd' },
                    prisma = { 'prettierd' },
                    python = { 'black' },
                    rust = { 'rustfmt' },
                    terraform = { 'prettierd' },
                    typescript = { 'prettierd' },
                    typescriptreact = { 'prettierd' },
                    yaml = { 'prettierd' },
                },
            }
            vim.keymap.set(
                'n',
                '<leader>cf',
                function() require('conform').format { lsp_fall = true, async = false, timeout_ms = 2000 } end,
                { desc = 'Code Format', silent = true }
            )
        end,
    },
    {
        'mfussenegger/nvim-lint',
        enabled = false,
        event = 'VeryLazy',
        config = function()
            require('lint').linters_by_ft = {
                markdown = { 'vale' },
                javascript = { 'eslint_d' },
                typescript = { 'eslint_d' },
                javascriptreact = { 'eslint_d' },
                typescriptreact = { 'eslint_d' },
            }
        end,
    },
}
