---@diagnostic disable: missing-fields

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    group = highlight_group,
    pattern = { '*.lua', '*.md', '*.ts', '*.js', '*.py', '*.go', '*.rs', '*.cpp', '*.c' },
})

-- [[ Disable numberline in CodeCompanion buffers ]]
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'codecompanion' },
    callback = function() vim.opt_local.number = false end,
})

-- [[ Set formatprg to jq for json files ]]
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'json' },
    callback = function() vim.api.nvim_set_option_value('formatprg', 'jq', { scope = 'local' }) end,
})

-- [[ Disable CursorLine if ft = markdown ]]
vim.api.nvim_create_autocmd('FileType', {
    desc = 'Disable cursorline for markdown',
    pattern = { 'markdown' },
    callback = function() vim.opt_local.cursorline = false end,
})

-- [[ Disable Noice LSP Progress if ft = rust ]]
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = { '*.rs' },
    callback = function()
        local ok, noice = pcall(require, 'noice')
        if ok then noice.setup({ lsp = { progress = { enabled = true } } }) end
    end,
})

-- [[ Auto Highlight on Search ]]
vim.on_key(function(char)
    if vim.fn.mode() == 'n' then
        local new_hlsearch = vim.tbl_contains({ '<CR>', 'n', 'N', '*', '#', '?', '/' }, vim.fn.keytrans(char))
        if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
    end
end, vim.api.nvim_create_namespace('auto_hlsearch'))

--[[ LSP Progress in LuaLine ]]
vim.api.nvim_create_augroup('lualine_augroup', { clear = true })
vim.api.nvim_create_autocmd('User', {
    group = 'lualine_augroup',
    pattern = 'LspProgressStatusUpdated',
    callback = require('lualine').refresh,
})

-- [[ TypeScript compiler setup for Neovim using npx tsc ]]
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'typescript',
    callback = function()
        vim.opt_local.makeprg = 'powershell -Command "npx tsc --noEmit | Out-String"'
        vim.opt_local.errorformat = '%f %#(%l\\,%c): %m'
    end,
})

-- [[ Enable completion for go files ]]
vim.api.nvim_create_autocmd({ 'LspAttach' }, {
    pattern = { '*.go' },
    callback = function(args) require('cmp_go_pkgs').init_items(args) end,
})

-- [[ console.log marco ]]
local esc = vim.api.nvim_replace_termcodes('<Esc>', true, true, true)
vim.fn.setreg('l', "yoconsole.log('" .. esc .. 'pa:' .. esc .. 'la, ' .. esc .. 'pl')

-- [[ Set titlestring to root directory ]]
vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
        local mini_misc_ok, mini_misc = pcall(require, 'mini.misc')
        local r = mini_misc_ok
            and mini_misc.find_root(
                0,
                { '.git', 'Makefile', '.root' },
                function() return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h') end
            )
        local rr = r and vim.fn.fnamemodify(r, ':t') or 'nvim'
        vim.opt.titlestring = rr
    end,
})

-- [[ Disable diagnostics for unused filetypes ]]
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'help', 'man', 'gitcommit', 'markdown', 'text' },
    callback = function() vim.diagnostic.enable(false) end,
})

--  TODO: [[ Disable gitsigns for files with ##noNvimGit ]]
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    callback = function(args)
        local bufnr = args.buf
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 5, false)
        for _, line in ipairs(lines) do
            if line:match('##noNvimGit') then
                -- Disable gitsigns for this buffer
                vim.b.gitsigns_disable = true
                vim.b.no_lualine_git = true
                return
            end
        end
    end,
})
