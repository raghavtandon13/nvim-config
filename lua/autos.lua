---@diagnostic disable: missing-fields

-- [[ Highlight on yank ]]

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- [[ Disable indentscope if ft = python ]]

vim.api.nvim_create_autocmd('FileType', {
    desc = 'Disable indentscope for certain filetypes',
    pattern = { 'python', 'text', 'markdown', 'yaml' },
    callback = function()
        vim.b.miniindentscope_disable = true
    end,
})

-- [[ Auto Highlight on Search ]]

vim.on_key(function(char)
    if vim.fn.mode() == 'n' then
        local new_hlsearch = vim.tbl_contains({ '<CR>', 'n', 'N', '*', '#', '?', '/' }, vim.fn.keytrans(char))
        if vim.opt.hlsearch:get() ~= new_hlsearch then
            vim.opt.hlsearch = new_hlsearch
        end
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

vim.keymap.set(
    'n',
    '<leader>te',
    '<cmd>lua toggle_diagnostics()<CR>',
    { desc = 'Toggle Diagnostics ', noremap = true, silent = true }
)

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

vim.api.nvim_set_keymap('v', '<Space>y', ':lua ConvertJSON()<CR>', { noremap = true, silent = true })

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
    callback = function(args)
        require('cmp_go_pkgs').init_items(args)
    end,
})
