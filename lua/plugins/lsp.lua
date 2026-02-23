------------------------------------------------------------------
-- [[ Languages Installed ]]
------------------------------------------------------------------
local language_servers = {
    clangd = {},
    gopls = {},
    lua_ls = {},
    pyright = {},
    rust_analyzer = {},
    tailwindcss = {},
    -- ts_ls = {},
    tsgo = {},
    ty = {},
    postgres_lsp = {},
    biome = {
        cmd = { 'biome', 'lsp-proxy' },
        filetypes = {
            'javascript',
            'javascriptreact',
            'json',
            'jsonc',
            'typescript',
            'typescript.tsx',
            'typescriptreact',
        },
        root_dir = function(fname) return vim.fs.root(fname, { 'biome.json', 'biome.jsonc' }) end,
        single_file_support = false,
    },
}

return {

    -- [[ CORE ]]
    {
        'neovim/nvim-lspconfig',
        event = 'VeryLazy',
        dependencies = {
            { 'williamboman/mason.nvim', opts = { ui = { border = 'single', height = 0.8 } }, config = true },
        },
    },

    -- [[ COMPLETION ]]
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            { 'onsails/lspkind-nvim', opts = { symbol_map = { Color = '󰝤', Supermaven = '' } } },
            {
                'folke/lazydev.nvim',
                ft = 'lua',
                opts = { library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } } },
            },
        },

        config = function()
            local cmp = require('cmp')
            require('lspconfig.ui.windows').default_options.border = 'single'
            cmp.setup({
                window = { completion = { border = 'rounded' }, documentation = { border = 'rounded' } },
                completion = { completeopt = 'menu,menuone,noinsert' },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-i>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                }),
                sources = { { name = 'nvim_lsp' } },
            })
        end,
    },

    -- [[ MASON ]]
    -- this downloads all the language servers and installs/enables them
    {
        'williamboman/mason-lspconfig.nvim',
        event = 'VeryLazy',
        config = function()
            require('mason-lspconfig').setup({
                automatic_installation = true,
                ensure_installed = vim.tbl_keys(language_servers),
            })
        end,
    },
}
