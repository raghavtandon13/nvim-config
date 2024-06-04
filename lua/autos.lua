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
