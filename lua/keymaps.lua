-- Window Navigation
vim.keymap.set(
    'n',
    '<C-\\>',
    require('smart-splits').move_cursor_previous,
    { desc = 'Move to Previous Window', silent = true }
)
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left, { desc = 'Move Cursor Left', silent = true })
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down, { desc = 'Move Cursor Down', silent = true })
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up, { desc = 'Move Cursor Up', silent = true })
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right, { desc = 'Move Cursor Right', silent = true })
vim.keymap.set('n', '<C-w>down', '<C-w>j', { desc = 'Focus Window Down', silent = true })
vim.keymap.set('n', '<C-w>left', '<C-w>h', { desc = 'Focus Window Left', silent = true })
vim.keymap.set('n', '<C-w>right', '<C-w>l', { desc = 'Focus Window Right', silent = true })
vim.keymap.set('n', '<C-w>up', '<C-w>k', { desc = 'Focus Window Up', silent = true })

-- Buffer Management
vim.keymap.set('n', '<c-left>', ':bNext<CR>', { desc = 'Next Buffer', silent = true })
vim.keymap.set('n', '<c-right>', ':bnext<CR>', { desc = 'Previous Buffer', silent = true })
vim.keymap.set('n', '<leader>bb', ':bd<CR>', { desc = 'Close Buffer', silent = true })
vim.keymap.set('n', '<leader>bh', require('smart-splits').swap_buf_left, { desc = 'Swap Buffer Left', silent = true })
vim.keymap.set('n', '<leader>bj', require('smart-splits').swap_buf_down, { desc = 'Swap Buffer Down', silent = true })
vim.keymap.set('n', '<leader>bk', require('smart-splits').swap_buf_up, { desc = 'Swap Buffer Up', silent = true })
vim.keymap.set('n', '<leader>bl', require('smart-splits').swap_buf_right, { desc = 'Swap Buffer Right', silent = true })

-- File Management
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save', silent = true })
vim.keymap.set('n', '<leader>e', ':Neotree float<CR>', { desc = 'File Explorer', silent = true })

-- LSP and Code Actions
vim.keymap.set(
    'n',
    '<leader>ca',
    ":lua vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }<CR>",
    { desc = '[C]ode [A]ction' }
)
vim.keymap.set('n', '<leader>rn', ':IncRename ', { desc = '[R]e[n]ame' })
vim.keymap.set('n', '<leader>D', require('telescope.builtin').lsp_type_definitions, { desc = 'Type [D]efinition' })
vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, { desc = '[G]oto [D]efinition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, { desc = '[G]oto [I]mplementation' })
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[G]oto [R]eferences' })

-- Diagnostics
vim.keymap.set(
    'n',
    '[d',
    '<cmd>lua vim.diagnostic.goto_prev({ float = false })<cr>',
    { desc = 'Go to previous diagnostic message', silent = true }
)
vim.keymap.set(
    'n',
    ']d',
    '<cmd>lua vim.diagnostic.goto_next({ float = false })<cr>',
    { desc = 'Go to next diagnostic message', silent = true }
)

-- Visual and Text Manipulation
vim.keymap.set('n', '<C-a>', 'gg<S-v><S-g>', { desc = 'Visual Select All', silent = true })
vim.keymap.set(
    'n',
    '<leader>cm',
    function() vim.api.nvim_put({ '' }, 'c', true, true) end,
    { desc = "Insert ''" }
)
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
vim.keymap.set('n', 'c', '"_c', { noremap = true, silent = true })
vim.keymap.set('n', 'd', '"_d', { noremap = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Debugging
vim.keymap.set('n', '<leader>dd', ':DBUIToggle<CR>', { desc = 'Debug UI', silent = true })

-- Git
vim.keymap.set('n', '<leader>gl', ':lua Snacks.lazygit()<CR>', { desc = 'Open Lazygit', silent = true })

-- Miscellaneous
vim.keymap.set('n', '<leader>aa', ':CodeCompanionChat<CR>', { desc = 'AI Chat', silent = true })
vim.keymap.set('n', '<leader>mt', ':TailwindSort<CR>', { desc = 'Sort Tailwind Classes', silent = true })
vim.keymap.set('n', '<leader>n', ':NoiceAll<CR>', { desc = 'Noice: for msgs', silent = true })

-- Split Resizing
vim.keymap.set('n', '<M-,>', require('smart-splits').resize_left, { desc = 'Resize Split Left', silent = true })
vim.keymap.set('n', '<M-.>', require('smart-splits').resize_right, { desc = 'Resize Split Right', silent = true })
vim.keymap.set('n', '<M-/>', require('smart-splits').resize_down, { desc = 'Resize Split Down', silent = true })
vim.keymap.set('n', '<M-;>', require('smart-splits').resize_up, { desc = 'Resize Split Up', silent = true })

-- Folding
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)

---------------------------------
vim.keymap.set(
    'n',
    '<leader>te',
    '<cmd>lua toggle_diagnostics()<CR>',
    { desc = 'Toggle Diagnostics ', noremap = true, silent = true }
)
vim.keymap.set(
    'v',
    '<Space>y',
    ':lua ConvertJSON()<CR>',
    { desc = 'Convert JS to JSON', noremap = true, silent = true }
)
vim.keymap.set(
    'n',
    'ga',
    ':lua MiniDiff.toggle_overlay()<CR>',
    { desc = 'Toggle Diff Overlay (Apply All)', noremap = true, silent = true }
)
