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
vim.keymap.set('n', '<leader>ba', ':CloseOtherBuffers<CR>', { desc = 'Close Buffer', silent = true })
vim.keymap.set('n', '<leader>bh', require('smart-splits').swap_buf_left, { desc = 'Swap Buffer Left', silent = true })
vim.keymap.set('n', '<leader>bj', require('smart-splits').swap_buf_down, { desc = 'Swap Buffer Down', silent = true })
vim.keymap.set('n', '<leader>bk', require('smart-splits').swap_buf_up, { desc = 'Swap Buffer Up', silent = true })
vim.keymap.set('n', '<leader>bl', require('smart-splits').swap_buf_right, { desc = 'Swap Buffer Right', silent = true })

-- File Management
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save', silent = true })
vim.keymap.set('n', '<leader>e', ':lua require("oil").open_float(".")<CR>', { desc = 'File Explorer', silent = true })
vim.keymap.set('n', '<leader>t', ':Todo<CR>', { desc = 'TODOs', silent = true })

-- LSP and Code Actions
vim.keymap.set(
    'n',
    '<leader>ca',
    ":lua vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }<CR>",
    { desc = '[C]ode [A]ction' }
)
vim.keymap.set('n', '<leader>rn', ':IncRename ', { desc = '[R]e[n]ame' })
vim.keymap.set('n', '<leader>D', ':lua Snacks.picker.lsp_type_definitions()<CR>', { desc = 'Type [D]efinition' })
vim.keymap.set('n', 'gd', ':lua Snacks.picker.lsp_definitions()<CR>', { desc = '[G]oto [D]efinition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
vim.keymap.set('n', 'gI', ':lua Snacks.picker.lsp_implementations()<CR>', { desc = '[G]oto [I]mplementation' })
vim.keymap.set('n', 'gr', ':lua Snacks.picker.lsp_references()<CR>', { desc = '[G]oto [R]eferences' })

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

--[[ Vertical Split default in :new  ]]
vim.api.nvim_create_user_command('New', 'vnew', {})
vim.cmd([[cnoreabbrev new New]])
vim.api.nvim_create_user_command('Hnew', 'new', {})
vim.cmd([[cnoreabbrev hnew Hnew]])

--[[ Opens Split Term and Runs Commands ]]
vim.api.nvim_create_user_command('Run', function(opts)
    local args = table.concat(opts.fargs, ' ')
    vim.cmd('vsplit | term ' .. args)
end, { nargs = '+' })

--[[ Toggle Inline Diagnostics ]]
local diagnostics_active = true
function _G.toggle_diagnostics()
    diagnostics_active = not diagnostics_active
    vim.diagnostic.config({ virtual_text = diagnostics_active })
    print('Diagnostics ' .. (diagnostics_active and 'enabled' or 'disabled'))
end

vim.api.nvim_create_user_command('CloseOtherBuffers', function()
    local bufs = vim.api.nvim_list_bufs()
    local current_buf = vim.api.nvim_get_current_buf()
    for _, i in ipairs(bufs) do
        if i ~= current_buf then vim.api.nvim_buf_delete(i, {}) end
    end
end, { desc = 'Close all buffers except the current one' })

function ConvertJSON()
    local start_line, start_col = unpack(vim.fn.getpos("'<"), 2, 3)
    local end_line, end_col = unpack(vim.fn.getpos("'>"), 2, 3)
    local range = string.format('%d,%d', start_line, end_line)
    vim.cmd(range .. 's/\\v(\\w+):/"\\1":/g') -- Quote keys
    vim.cmd(range .. 's/\'/"/g') -- Convert single quotes to double quotes
end

--[[ HELPERS ]]

local function search_d_drive()
    require('snacks.picker').files({
        cwd = 'D:/',
        hidden = true,
        ignored = true,
        follow = true,
        exclude = {
            '$RECYCLE.BIN',
            '.bun',
            '.cache',
            '.expo',
            '.git',
            '.local',
            '.logseq',
            '.obsidian',
            '.pm2',
            '.prettierd',
            '.zsh',
            'CrashDumps',
            'Games',
            'go',
            'go-build',
            'gopls',
            'Microsoft',
            'Mongodb Compass',
            'node-gyp',
            'node_modules',
            'NoSQLBooster',
            'nvim-data',
            'obsidian',
            'Packages',
            'Postman',
            'powerlevel10k',
            'PowerShell',
            'Rainmeter',
            'raycast-x',
            'scoop',
            'Softdeluxe',
            'target',
            'Temp',
            'tlrc',
            'TV',
            'uv',
            'venv',
            'wezterm',
            'Windows',
            'WindowsPowerShell',
            'ZenProfile',
            'zig',
            'Edge Extension',
        },
    })
end
vim.api.nvim_create_user_command('FZF', search_d_drive, {})

local find_root = function()
    return require('mini.misc').find_root(
        0,
        { '.git', 'Makefile', '.root' },
        function() return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h') end
    )
end

local grep_project = function()
    local root = find_root()
    Snacks.picker.grep({ cwd = root })
end

local search_files_project = function()
    local root = find_root()
    Snacks.picker.files({ cwd = root })
end

-- Snacks Pickers

vim.keymap.set('n', '<leader>,', ':lua Snacks.picker.buffers()<CR>', { desc = 'Search Open Buffers', silent = true })
vim.keymap.set('n', '<leader>?', ':lua Snacks.picker.recent()<CR>', { desc = 'Search Recent Files', silent = true })
vim.keymap.set('n', '<leader>gs', ':lua Snacks.picker.git_status()<CR>', { desc = 'Search Git Status', silent = true }) --  TODO: change keybind
vim.keymap.set(
    'n',
    '<leader>s/',
    ':lua Snacks.picker.grep_buffers()<CR>',
    { desc = 'Grep in Open Files', silent = true }
)
vim.keymap.set('n', '<leader>sa', ':FZF<cr>', { desc = 'Search All Files (D)', silent = true })
vim.keymap.set(
    'n',
    '<leader>sd',
    ':lua Snacks.picker.diagnostics()<CR>',
    { desc = 'Search Diagnostics', silent = true }
)
vim.keymap.set('n', '<leader>sh', ':lua Snacks.picker.help()<CR>', { desc = 'Search Help', silent = true })
vim.keymap.set('n', '<leader>sw', ':lua Snacks.picker.grep_word()<CR>', { desc = 'Grep Word', silent = true })
vim.keymap.set('n', '<leader>ss', ':lua Snacks.picker.pickers()<CR>', { desc = 'Search Pickers', silent = true })
vim.keymap.set(
    'n',
    '<leader>so',
    ":lua Snacks.picker.files({cwd = 'D:/Notes'})<CR>",
    { desc = 'Search Notes', silent = true }
)
vim.keymap.set('n', '<leader>sg', grep_project, { desc = 'Grep', silent = true })
vim.keymap.set('n', '<leader><space>', search_files_project, { desc = 'Search Files', silent = true })
vim.keymap.set(
    'n',
    '<leader>sn',
    ":lua Snacks.picker.files({cwd = vim.fn.stdpath('config')})<CR>",
    { desc = 'Search Neovim Config', silent = true }
)
vim.keymap.set('n', '<leader>dy', function()
    local line = vim.api.nvim_win_get_cursor(0)[1] - 1
    local diags = vim.diagnostic.get(0, { lnum = line })

    if #diags == 0 then
        vim.notify('No diagnostics on this line', vim.log.levels.WARN)
        return
    end

    local msg = diags[1].message
    vim.fn.setreg('+', msg) -- copy to system clipboard
    vim.notify('Copied diagnostic message.')
end)
