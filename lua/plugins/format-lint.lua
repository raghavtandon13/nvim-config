return {
    {
        'stevearc/conform.nvim',
        event = 'VeryLazy',
        config = function()
            require('conform').setup({
                notify_on_error = false,
                formatters_by_ft = {
                    c = { 'clang-format' },
                    cpp = { 'clang-format' },
                    css = { 'prettierd' },
                    go = { 'gofmt' },
                    html = { 'prettierd' },
                    javascript = { 'biome' },
                    javascriptreact = { 'biome' },
                    json = { 'biome' },
                    jsonc = { 'biome' },
                    lua = { 'stylua' },
                    markdown = { 'prettierd' },
                    prisma = { 'prettierd' },
                    python = { 'ruff_format' },
                    rust = { 'rustfmt' },
                    terraform = { 'prettierd' },
                    typescript = { 'biome' },
                    typescriptreact = { 'biome' },
                    yaml = { 'prettierd' },
                },
            })
            vim.keymap.set(
                'n',
                '<leader>cf',
                function()
                    require('conform').format({
                        lsp_fall = true,
                        async = false,
                        timeout_ms = 2000,
                    })
                end,
                { desc = 'Code Format', silent = true }
            )
        end,
    },
    {
        'mfussenegger/nvim-lint',
        enabled = true,
        event = 'VeryLazy',
        config = function()
            require('lint').linters_by_ft = {
                markdown = { 'vale' },
                javascript = { 'eslint_d' },
                typescript = { 'eslint_d' },
                javascriptreact = { 'eslint_d' },
                typescriptreact = { 'eslint_d' },
            }
            vim.keymap.set('n', '<leader>cl', function() require('lint').try_lint() end, { desc = 'Code Lint', silent = true })
        end,
    },
}
