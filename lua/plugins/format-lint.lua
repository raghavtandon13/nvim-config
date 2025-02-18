return {
    {
        'stevearc/conform.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('conform').setup {
                format_on_save = {
                    timeout_ms = 500,
                },
                notify_on_error = false,
                formatters_by_ft = {
                    lua = { 'stylua' },
                    javascript = { 'prettier' },
                    typescript = { 'prettier' },
                    javascriptreact = { 'prettier' },
                    typescriptreact = { 'prettier' },
                    html = { 'prettier' },
                    css = { 'prettier' },
                    json = { 'prettier' },
                    markdown = { 'prettier' },
                    go = { 'gofumpt' },
                    python = { 'black' },
                    cpp = { 'clang-format' },
                    c = { 'clang-format' },
                    rust = { 'rustfmt' },
                    prisma = { 'prettier' },
                    yaml = { 'prettier' },
                },
            }
            vim.keymap.set('n', '<leader>cf', function()
                require('conform').format { lsp_fall = true, async = false, timeout_ms = 2000 }
            end, { desc = 'Code Format', silent = true })
        end,
    },
    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
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
