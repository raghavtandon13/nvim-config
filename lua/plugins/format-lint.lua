return {
    {
        'stevearc/conform.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('conform').setup {
                notify_on_error = false,
                formatters_by_ft = {
                    lua = { 'stylua' },
                    javascript = { 'prettierd' },
                    typescript = { 'prettierd' },
                    javascriptreact = { 'prettierd' },
                    typescriptreact = { 'prettierd' },
                    html = { 'prettierd' },
                    json = { 'prettierd' },
                    markdown = { 'prettierd' },
                    go = { 'gofumpt' },
                    python = { 'black' },
                    cpp = { 'clang-format' },
                    c = { 'clang-format' },
                },
            }
            vim.keymap.set('n', '<leader>mm', function()
                require('conform').format {
                    lsp_fall = true,
                    async = false,
                    timeout_ms = 2000,
                }
                -- vim.cmd 'Format'
            end)
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
