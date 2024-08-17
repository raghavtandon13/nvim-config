vim.keymap.set('n', '<C-a>', 'gg<S-v><S-g>', { desc = 'Visual Select All', silent = true })
vim.keymap.set('n', '<c-left>', ':bNext<CR>', { desc = 'Next Buffer', silent = true })
vim.keymap.set('n', '<c-right>', ':bnext<CR>', { desc = 'Previous Buffer', silent = true })
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save', silent = true })
vim.keymap.set('n', '<C-w>down', '<C-w>j', { desc = 'Focus Window Down', silent = true })
vim.keymap.set('n', '<C-w>left', '<C-w>h', { desc = 'Focus Window Left', silent = true })
vim.keymap.set('n', '<C-w>right', '<C-w>l', { desc = 'Focus Window Right', silent = true })
vim.keymap.set('n', '<C-w>up', '<C-w>k', { desc = 'Focus Window Up', silent = true })
vim.keymap.set('n', '<leader>bb', ':bd<CR>', { desc = 'Close Buffer', silent = true })
vim.keymap.set('n', '<leader>cc', ':vsplit | term gcc % && a.exe<CR>i', { desc = 'gcc compile and run', silent = true })
vim.keymap.set('n', '<leader>cr', ':vsplit | term cargo run<CR>i', { desc = 'cargo run', silent = true })
vim.keymap.set('n', '<leader>dd', ':DBUIToggle<CR>', { desc = 'Open definition in vsplit', silent = true })
vim.keymap.set('n', '<leader>e', ':Neotree float<CR>', { desc = 'File Explorer', silent = true })
vim.keymap.set('n', '<leader>ll', ':LspRestart<CR>', { desc = 'LSP Restart', silent = true })
vim.keymap.set('n', '<leader>th', ':InlayHintsToggle<CR>', { desc = 'Toggle Inline Hints', silent = true })
vim.keymap.set('n', '<leader>mt', ':TailwindSort<CR>', { desc = 'Sort Tailwind Classes', silent = true })
vim.keymap.set(
    'n',
    '<leader>lv',
    ':vsplit | Telescope lsp_definitions<CR>',
    { desc = 'Open definition in vsplit', silent = true }
)
vim.keymap.set('n', '<leader>n', ':NoiceAll<CR>', { desc = 'Noice: for msgs', silent = true })
vim.keymap.set(
    'n',
    '<leader>tc',
    ':lua vim.opt.conceallevel = vim.opt.conceallevel:get() == 0 and 2 or 0<CR>',
    { desc = 'Toggle Code Conceal', silent = true }
)
vim.keymap.set(
    'n',
    '<Leader>tl',
    ':lua vim.wo.number = not vim.wo.number<CR>',
    { noremap = true, silent = true, desc = 'Toggle Number Line' }
)
vim.keymap.set('n', '<leader>tt', ':Trouble diagnostics toggle<CR>', { desc = 'Toggle Trouble', silent = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message', silent = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message', silent = true })
vim.keymap.set('n', 'c', '"_c', { noremap = true, silent = true })
vim.keymap.set('n', 'd', '"_d', { noremap = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('t', '<C-t>', '<C-\\><C-n>', { noremap = true, silent = true })

-- resizing splits
vim.keymap.set('n', '<M-;>', require('smart-splits').resize_up)
vim.keymap.set('n', '<M-/>', require('smart-splits').resize_down)
vim.keymap.set('n', '<M-,>', require('smart-splits').resize_left)
vim.keymap.set('n', '<M-.>', require('smart-splits').resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set('n', '<leader>\\', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
