---@diagnostic disable: missing-fields

return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function() return vim.fn.executable 'make' == 1 end,
        },
    },

    config = function()
        --[[ SETUP ]]

        require('telescope').setup {
            defaults = {
                file_ignore_patterns = { 'node_modules', 'build', 'dist', 'yarn.lock', '.spec.ts', 'venv' },
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-x>'] = require('telescope.actions').select_vertical,
                        ['<C-d>'] = require('telescope.actions').delete_buffer,
                        ['<M-q>'] = require('telescope.actions').add_selected_to_qflist,
                    },
                },
            },
            extensions = {
                fzf = {},
                ['ui-select'] = { require('telescope.themes').get_dropdown {} },
            },
        }

        --[[ HELPERS ]]

        -- Search All (D:/)
        -- local excluded_dirs = { 'Windows', 'node_modules', 'venv', 'Games', 'TV', '.cache', 'scoop', 'Microsoft', 'nvim-data', 'Packages', 'Temp', 'node-gyp', 'gopls', 'go-build', 'Postman', '.git', 'Rainmeter', '.obsidian', 'obsidian', '$RECYCLE.BIN' }
        -- local exclude_args = {}
        -- for _, dir in ipairs(excluded_dirs) do
        --     table.insert(exclude_args, '--exclude=' .. dir)
        -- end
        -- local find_command = { 'fd', '.', 'D:/', '-L', '-H' }
        -- vim.list_extend(find_command, exclude_args)
        -- local function search_d_drive()
        --     require('telescope.builtin').find_files { prompt_title = 'Search D:/', find_command = find_command }
        -- end
        -- vim.api.nvim_create_user_command('FZF', search_d_drive, {})

        -------------------------
        local function search_d_drive()
            require('snacks.picker').files {
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
                },
            }
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
            Snacks.picker.grep { cwd = root }
        end

        local search_files_project = function()
            local root = find_root()
            Snacks.picker.files { cwd = root }
        end

        --[[ KEYMAPS ]]

        vim.keymap.set(
            'n',
            '<leader>,',
            ':lua Snacks.picker.buffers()<CR>',
            { desc = 'Search Open Buffers', silent = true }
        )
        vim.keymap.set(
            'n',
            '<leader>?',
            ':lua Snacks.picker.recent()<CR>',
            { desc = 'Search Recent Files', silent = true }
        )
        vim.keymap.set(
            'n',
            '<leader>gs',
            ':lua Snacks.picker.git_status()<CR>',
            { desc = 'Search Git Status', silent = true }
        ) --  TODO: change keybind
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
        vim.keymap.set(
            'n',
            '<leader>ss',
            ':lua Snacks.picker.pickers()<CR>',
            { desc = 'Search Pickers', silent = true }
        )
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
            vim.notify 'Copied diagnostic message.'
        end)
    end,
}
