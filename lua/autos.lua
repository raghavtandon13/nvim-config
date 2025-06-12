---@diagnostic disable: missing-fields

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    group = highlight_group,
    pattern = '*',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'codecompanion' },
    callback = function() vim.opt_local.number = false end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'json' },
    callback = function() vim.api.nvim_set_option_value('formatprg', 'jq', { scope = 'local' }) end,
})

-- -- [[ Disable CursorLine if ft = markdown ]]
vim.api.nvim_create_autocmd('FileType', {
    desc = 'Disable cursorline for markdown',
    pattern = { 'markdown' },
    callback = function() vim.opt_local.cursorline = false end,
})

-- [[ Disable Noice LSP Progress if ft = rust ]]
vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
        local ft = vim.bo.filetype
        local enable = (ft == 'rust') -- only enable for rust
        local ok, noice = pcall(require, 'noice')
        if ok then noice.setup { lsp = { progress = { enabled = enable } } } end
    end,
})

-- -- [[ Disable Snacks Indent if ft = terraform ]]
-- vim.api.nvim_create_autocmd('FileType', {
--     desc = 'Disable indentscope for certain filetypes',
--     pattern = { 'terraform', 'text', 'markdown', 'yaml' },
--     callback = function() vim.cmd [[lua Snacks.indent.disable()]] end,
-- })

-- -- [[ Disable indentscope if ft = python ]] -- OLD
-- vim.api.nvim_create_autocmd('FileType', {
--     desc = 'Disable indentscope for certain filetypes',
--     pattern = { 'python', 'text', 'markdown', 'yaml' },
--     callback = function() vim.b.miniindentscope_disable = true end,
-- })

-- [[ Auto Highlight on Search ]]
vim.on_key(function(char)
    if vim.fn.mode() == 'n' then
        local new_hlsearch = vim.tbl_contains({ '<CR>', 'n', 'N', '*', '#', '?', '/' }, vim.fn.keytrans(char))
        if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
    end
end, vim.api.nvim_create_namespace 'auto_hlsearch')

--[[ LSP Progress in LuaLine ]]
vim.api.nvim_create_augroup('lualine_augroup', { clear = true })
vim.api.nvim_create_autocmd('User', {
    group = 'lualine_augroup',
    pattern = 'LspProgressStatusUpdated',
    callback = require('lualine').refresh,
})

--[[ Vertical Split default in :new  ]]
vim.api.nvim_create_user_command('New', 'vnew', {})
vim.cmd [[cnoreabbrev new New]]
vim.api.nvim_create_user_command('Hnew', 'new', {})
vim.cmd [[cnoreabbrev hnew Hnew]]

--[[ Opens Split Term and Runs Commands ]]
vim.api.nvim_create_user_command('Run', function(opts)
    local args = table.concat(opts.fargs, ' ')
    vim.cmd('vsplit | term ' .. args)
end, { nargs = '+' })

--[[ Toggle Inline Diagnostics ]]
local diagnostics_active = true
function _G.toggle_diagnostics()
    diagnostics_active = not diagnostics_active
    vim.diagnostic.config {
        virtual_text = diagnostics_active,
    }
    print('Diagnostics ' .. (diagnostics_active and 'enabled' or 'disabled'))
end

-- TypeScript compiler setup for Neovim using npx tsc
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'typescript',
    callback = function()
        vim.opt_local.makeprg = 'powershell -Command "npx tsc --noEmit | Out-String"'
        vim.opt_local.errorformat = '%f %#(%l\\,%c): %m'
    end,
})

function ConvertJSON()
    local start_line, start_col = unpack(vim.fn.getpos "'<", 2, 3)
    local end_line, end_col = unpack(vim.fn.getpos "'>", 2, 3)
    local range = string.format('%d,%d', start_line, end_line)
    vim.cmd(range .. 's/\\v(\\w+):/"\\1":/g') -- Quote keys
    vim.cmd(range .. 's/\'/"/g') -- Convert single quotes to double quotes
end

vim.api.nvim_create_user_command('Light', function()
    require('rose-pine').setup { styles = { transparency = false } }
    vim.cmd 'colorscheme rose-pine-dawn'
    vim.cmd 'source ~/.config/nvim/lua/highlights.lua'
end, {})

vim.api.nvim_create_user_command('Dark', function()
    require('rose-pine').setup { styles = { transparency = true } }
    vim.cmd 'colorscheme rose-pine'
    vim.cmd 'source ~/.config/nvim/lua/highlights.lua'
end, {})

vim.api.nvim_create_autocmd({ 'LspAttach' }, {
    pattern = { '*.go' },
    callback = function(args) require('cmp_go_pkgs').init_items(args) end,
})

-- [[ MACROS ]]
-- [[ console.log marco ]]
local esc = vim.api.nvim_replace_termcodes('<Esc>', true, true, true)
vim.fn.setreg('l', "yoconsole.log('" .. esc .. 'pa:' .. esc .. 'la, ' .. esc .. 'pl')

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
