return {
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'williamboman/mason.nvim', opts = { ui = { border = 'single', height = 0.8 } }, config = true },
            { 'williamboman/mason-lspconfig.nvim', opts = {} },
        },
    },
    {
        'hrsh7th/nvim-cmp',
        event = { 'InsertEnter' },
        dependencies = {
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'rafamadriz/friendly-snippets',
            'saadparwaiz1/cmp_luasnip',
            { 'luckasRanarison/tailwind-tools.nvim', opts = {} },
            { 'onsails/lspkind-nvim', opts = { symbol_map = { Color = '󰝤' } } },
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            require('luasnip.loaders.from_vscode').lazy_load()
            require('lspconfig.ui.windows').default_options.border = 'single'
            luasnip.config.setup {}

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
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
                formatting = {
                    format = require('lspkind').cmp_format {
                        before = require('tailwind-tools.cmp').lspkind_format,
                    },
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-i>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'codeium' },
                },
            }
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            local servers = {
                html = { filetypes = { 'html', 'jsx', 'tsx' } },
                lua_ls = {
                    Lua = {
                        hint = { enable = true },
                        runtime = { version = 'LuaJIT' },
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME, '${3rd}/luv/library', '${3rd}/busted/library' },
                        },
                        completion = { callSnippet = 'Replace' },
                        telemetry = { enable = false },
                        diagnostics = { disable = { 'missing-fields', 'undefined-field' } },
                    },
                },
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
                tsserver = {
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
            }

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            local on_attach = function(_, bufnr)
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end
                    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
                end

                --[[ Keymaps ]]

                nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
                nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
                nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
                nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
                nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
                nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
                nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
                nmap(
                    '<leader>wl',
                    ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                    '[W]orkspace [L]ist Folders'
                )
                nmap(
                    '<leader>ca',
                    ":lua vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }<CR>",
                    '[C]ode [A]ction'
                )

                --[[ Customizations ]]

                -- Function to Hide TSServer Diagnostics
                -- https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
                -- 80001 or 80007 --> "File is a CommonJS module; it may be converted to an ES module."

                local function filter_tsserver_diagnostics(_, result, ctx, config)
                    require('ts-error-translator').translate_diagnostics(_, result, ctx, config)
                    if result.diagnostics == nil then
                        return
                    end
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
                vim.lsp.handlers['textDocument/hover'] =
                    vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded', width = 60, max_height = 50 })
                vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                    vim.lsp.buf.format()
                end, { desc = 'Format current buffer with LSP' })
                vim.diagnostic.config { float = { border = 'rounded' } }
            end

            local mason_lspconfig = require 'mason-lspconfig'
            mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers) }
            mason_lspconfig.setup_handlers {
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    }
                end,
            }
        end,
    },
}
