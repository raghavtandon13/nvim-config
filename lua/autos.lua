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
