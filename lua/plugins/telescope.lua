return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim', {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    } },
    config = function()
        --[[ SETUP ]]
        require('telescope').setup {
            defaults = {
                file_ignore_patterns = { 'node_modules', 'build', 'dist', 'yarn.lock', '.spec.ts', 'venv' },
                mappings = { i = {
                    ['<C-u>'] = false,
                    ['<C-x>'] = require('telescope.actions').select_vertical,
                    ['<C-d>'] = require('telescope.actions').delete_buffer,
                    ['<M-q>'] = require('telescope.actions').add_selected_to_qflist,
                } },
            },
        }
        pcall(require('telescope').load_extension, 'fzf')

        --[[ HELPERS ]]
        local function find_git_root()
            local current_file = vim.api.nvim_buf_get_name(0)
            local current_dir
            local cwd = vim.fn.getcwd()
            if current_file == '' then
                current_dir = cwd
            else
                current_dir = vim.fn.fnamemodify(current_file, ':h')
            end
            local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
            if vim.v.shell_error ~= 0 then
                print 'Not git repo. Error from telescope.lua'
                return cwd
            end
            return git_root
        end

        local function live_grep_git_root()
            local git_root = find_git_root()
            if git_root then
                require('telescope.builtin').live_grep { search_dirs = { git_root } }
            end
        end
        vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

        local function telescope_live_grep_open_files()
            require('telescope.builtin').live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
        end

        local excluded_dirs = { 'Windows', 'node_modules', 'venv', 'Games', 'TV', '.cache', 'scoop', 'Microsoft', 'nvim-data', 'Packages', 'Temp', 'node-gyp', 'gopls', 'go-build', 'Postman', '.git', 'Rainmeter', '.obsidian', 'obsidian', '$RECYCLE.BIN' }
        local exclude_args = {}
        for _, dir in ipairs(excluded_dirs) do
            table.insert(exclude_args, '--exclude=' .. dir)
        end
        local find_command = { 'fd', '.', 'D:/', '-L', '-H' }
        vim.list_extend(find_command, exclude_args)
        local function search_d_drive()
            require('telescope.builtin').find_files { prompt_title = 'Search D:/', find_command = find_command }
        end
        vim.api.nvim_create_user_command('FZF', search_d_drive, {})

        --[[ KEYMAPS ]]
        vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = 'Search Recent Files' })
        vim.keymap.set('n', '<leader>,', require('telescope.builtin').buffers, { desc = 'Search Open Buffers' })
        vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = 'Grep in Open Files' })
        vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = 'Search Telescope' })
        vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = 'Search Git Status' })
        vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Search Help' })
        vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = 'Search Word under cursor' })
        vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = 'Grep' })
        vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = 'Grep Git Root' })
        vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
        vim.keymap.set('n', '<leader>sa', ':FZF<cr>', { desc = 'Search All Files (D)' })

        vim.keymap.set('n', '<leader>/', function()
            require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false })
        end, { desc = 'Grep in current buffer' })

        vim.keymap.set('n', '<leader>gf', function()
            require('telescope.builtin').git_files { layout_strategy = 'vertical', layout_config = { width = 0.8 } }
        end, { desc = 'Search Git Files' })

        vim.keymap.set('n', '<leader>sn', function()
            require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
        end, { desc = 'Search Neovim Config' })

        vim.keymap.set('n', '<leader><space>', function()
            xpcall(function()
                require('telescope.builtin').git_files { layout_strategy = 'vertical', layout_config = { width = 0.8 } }
            end, function()
                print 'No Git Repo'
                require('telescope.builtin').find_files { layout_config = { width = 0.8 } }
            end)
        end, { desc = 'Search Files' })
    end,
}
