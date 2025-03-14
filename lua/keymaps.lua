vim.keymap.set('n', '<C-a>', 'gg<S-v><S-g>', { desc = 'Visual Select All', silent = true })
vim.keymap.set('n', '<c-left>', ':bNext<CR>', { desc = 'Next Buffer', silent = true })
vim.keymap.set('n', '<c-right>', ':bnext<CR>', { desc = 'Previous Buffer', silent = true })
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save', silent = true })
vim.keymap.set('n', '<C-w>down', '<C-w>j', { desc = 'Focus Window Down', silent = true })
vim.keymap.set('n', '<C-w>left', '<C-w>h', { desc = 'Focus Window Left', silent = true })
vim.keymap.set('n', '<C-w>right', '<C-w>l', { desc = 'Focus Window Right', silent = true })
vim.keymap.set('n', '<C-w>up', '<C-w>k', { desc = 'Focus Window Up', silent = true })
vim.keymap.set('n', '<leader>bb', ':bd<CR>', { desc = 'Close Buffer', silent = true })
vim.keymap.set('n', '<leader>dd', ':DBUIToggle<CR>', { desc = 'Debug UI', silent = true })
vim.keymap.set('n', '<leader>e', ':Neotree float<CR>', { desc = 'File Explorer', silent = true })
vim.keymap.set('n', '<leader>gl', ':lua Snacks.lazygit()<CR>', { desc = 'Open Lazygit', silent = true })
vim.keymap.set('n', '<leader>mt', ':TailwindSort<CR>', { desc = 'Sort Tailwind Classes', silent = true })
vim.keymap.set('n', '<leader>n', ':NoiceAll<CR>', { desc = 'Noice: for msgs', silent = true })
vim.keymap.set(
    'n',
    '<leader>tc',
    ':lua vim.opt.conceallevel = vim.opt.conceallevel:get() == 0 and 2 or 0<CR>',
    { desc = 'Toggle Code Conceal', silent = true }
)
vim.keymap.set('n', '<leader>th', ':InlayHintsToggle<CR>', { desc = 'Toggle Inline Hints', silent = true })
vim.keymap.set(
    'n',
    '<Leader>tl',
    ':lua vim.wo.number = not vim.wo.number<CR>',
    { noremap = true, silent = true, desc = 'Toggle Number Line' }
)
vim.keymap.set('n', '<leader>tt', ':Trouble diagnostics toggle<CR>', { desc = 'Toggle Trouble', silent = true })
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ float = false })<cr>', { desc = 'Go to previous diagnostic message', silent = true })
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ float = false })<cr>' , { desc = 'Go to next diagnostic message', silent = true })
vim.keymap.set('n', 'c', '"_c', { noremap = true, silent = true })
vim.keymap.set('n', 'd', '"_d', { noremap = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set(
    't',
    '<c-t>',
    ':lua vim.api.nvim_feedkeys("\\<Esc>", "n", true); vim.api.nvim_feedkeys("\\<Esc>", "n", true); Snacks.terminal()<CR>',
    { noremap = true, silent = true, desc = 'Toggle Terminal' }
)
vim.keymap.set(
    { 'n', 'v', 'i' },
    '<c-t>',
    ':lua Snacks.terminal()<CR>',
    { noremap = true, silent = true, desc = 'Toggle Terminal' }
)

vim.keymap.set('n', '<leader>aa', ':CopilotChatToggle<CR>', { desc = 'Toggle Trouble', silent = true })

-- resizing splits
vim.keymap.set('n', '<M-;>', require('smart-splits').resize_up, { desc = 'Resize Split Up', silent = true })
vim.keymap.set('n', '<M-/>', require('smart-splits').resize_down, { desc = 'Resize Split Down', silent = true })
vim.keymap.set('n', '<M-,>', require('smart-splits').resize_left, { desc = 'Resize Split Left', silent = true })
vim.keymap.set('n', '<M-.>', require('smart-splits').resize_right, { desc = 'Resize Split Right', silent = true })

-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left, { desc = 'Move Cursor Left', silent = true })
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down, { desc = 'Move Cursor Down', silent = true })
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up, { desc = 'Move Cursor Up', silent = true })
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right, { desc = 'Move Cursor Right', silent = true })
vim.keymap.set(
    'n',
    '<C-\\>',
    require('smart-splits').move_cursor_previous,
    { desc = 'Move to Previous Window', silent = true }
)

-- swapping buffers between windows
vim.keymap.set('n', '<leader>\\', require('smart-splits').swap_buf_left, { desc = 'Swap Buffer Left', silent = true })
vim.keymap.set('n', '<leader>bh', require('smart-splits').swap_buf_left, { desc = 'Swap Buffer Left', silent = true })
vim.keymap.set('n', '<leader>bj', require('smart-splits').swap_buf_down, { desc = 'Swap Buffer Down', silent = true })
vim.keymap.set('n', '<leader>bk', require('smart-splits').swap_buf_up, { desc = 'Swap Buffer Up', silent = true })
vim.keymap.set('n', '<leader>bl', require('smart-splits').swap_buf_right, { desc = 'Swap Buffer Right', silent = true })
