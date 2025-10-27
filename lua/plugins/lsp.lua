---@diagnostic disable: missing-fields

return {
    {
        'ibhagwan/fzf-lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {},
    },
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = {
            { 'williamboman/mason.nvim', opts = { ui = { border = 'single', height = 0.8 } }, config = true },
            { 'williamboman/mason-lspconfig.nvim', opts = {} },
        },
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'rafamadriz/friendly-snippets',
            'saadparwaiz1/cmp_luasnip',
            'Yu-Leo/cmp-go-pkgs',
            { 'onsails/lspkind-nvim', opts = { symbol_map = { Color = '󰝤', Supermaven = '' } } },
            {
                'folke/lazydev.nvim',
                ft = 'lua',
                opts = { library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } } },
            },
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            require('luasnip.loaders.from_vscode').lazy_load()
            require('lspconfig.ui.windows').default_options.border = 'single'
            luasnip.config.setup {}
            cmp.setup {
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                window = {
                    completion = cmp.config.window.bordered {
                        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
                    },
                    documentation = cmp.config.window.bordered {
                        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
                    },
                },
                completion = { completeopt = 'menu,menuone,noinsert' },
                -- formatting = { format = require('lspkind').cmp_format { before = require('tailwind-tools.cmp').lspkind_format } },
                mapping = cmp.mapping.preset.insert {
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-i>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
                },
                sources = { { name = 'nvim_lsp' }, { name = 'luasnip' } },
            }
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            local servers = {
                clangd = { filetypes = { 'c', 'cpp', 'objc', 'objcpp' } },
                html = { filetypes = { 'html', 'jsx', 'tsx' } },
                lua_ls = {},
                pyright = {},
                rust_analyzer = {
                    filetypes = { 'rust' },
                    settings = {
                        ['rust-analyzer'] = {
                            lens = { enable = true },
                            cargo = { allFeatures = true },
                            inlayHints = {
                                bindingModeHints = { enable = false },
                                chainingHints = { enable = true },
                                closingBraceHints = { enable = true, minLines = 25 },
                                closureReturnTypeHints = { enable = 'never' },
                                lifetimeElisionHints = { enable = 'never', useParameterNames = false },
                                maxLength = 25,
                                parameterHints = { enable = true },
                                reborrowHints = { enable = 'never' },
                                renderColons = true,
                                typeHints = {
                                    enable = true,
                                    hideClosureInitialization = false,
                                    hideNamedConstructor = false,
                                },
                            },
                        },
                    },
                },
                tailwindcss = {},
                ts_ls = {
                    settings = {
                        typescript = {
                            inlayHints = {
                                includeInlayParameterNameHints = 'all',
                                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                        },
                        javascript = {
                            inlayHints = {
                                includeInlayParameterNameHints = 'all',
                                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                        },
                    },
                },
                gopls = {},
            }

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities) -- old nvim-cmp

            -- Mason & LSP capabilities
            local mason_lspconfig = require 'mason-lspconfig'
            mason_lspconfig.setup { automatic_installation = true, ensure_installed = vim.tbl_keys(servers) }

            -- Code Folding Capabilities
            -- capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
            -- require('ufo').setup()

            -- -- Function to Hide TSServer Diagnostics
            local function filter_tsserver_diagnostics(_, result, ctx, config)
                require('ts-error-translator').translate_diagnostics(_, result, ctx)
                if result.diagnostics == nil then return end
                local idx = 1
                while idx <= #result.diagnostics do
                    local entry = result.diagnostics[idx]
                    if entry.code == 80001 or entry.code == 80007 then
                        table.remove(result.diagnostics, idx)
                    else
                        idx = idx + 1
                    end
                end
                vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
            end
            vim.lsp.handlers['textDocument/publishDiagnostics'] = filter_tsserver_diagnostics

            -- https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
            -- 80001 or 80007 --> "File is a CommonJS module; it may be converted to an ES module."
        end,
    },
}
