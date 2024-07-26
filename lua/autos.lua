-- [[ Highlight on yank ]]

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- [[ Save view on save ]]

vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
    pattern = { '*.*' },
    desc = 'save view (folds), when closing file',
    command = 'mkview',
})

-- [[ Loan view on start ]]

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    pattern = { '*.*' },
    desc = 'load view (folds), when opening file',
    command = 'silent! loadview',
})

-- [[ Disable indentscope if ft = python ]]

vim.api.nvim_create_autocmd('FileType', {
    desc = 'Disable indentscope for certain filetypes',
    pattern = { 'python' },
    callback = function()
        vim.b.miniindentscope_disable = true
    end,
})

-- [[ Custom Fold Text ]]

function _G.custom_fold_text()
    local line = vim.fn.getline(vim.v.foldstart)
    return ' ' .. line .. ' '
end
vim.opt.foldtext = 'v:lua.custom_fold_text()'

-- [[ Delete view data of buffer ]]
-- Delview to remove all folds. This deletes view files for current file.

function Delete_view()
    local path = vim.fn.fnamemodify(vim.fn.bufname '%', ':p')
    path = string.gsub(path, '=', '==')
    path = string.gsub(path, '/', '=+')
    path = string.gsub(path, '\\', '=+')
    path = string.gsub(path, ':', '=-') .. '='
    path = string.gsub(vim.o.viewdir, '\\\\', '\\') .. path
    os.remove(path)
    print 'Deleted View'
    vim.cmd 'e'
end
vim.cmd ':command! Delview lua Delete_view()'
vim.cmd ":cabbrev delview <c-r>=(getcmdtype()==':' and getcmdpos()==1 and 'Delview' or 'delview')<CR>"

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
