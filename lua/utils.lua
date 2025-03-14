local git_root = function()
    local root = require('mini.misc').find_root(0, { '.git', 'Makefile' }, function()
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h')
    end)
    return root or vim.fn.expand('%:p:h')
end

local relative_path_from_git_root = function()
    local root = git_root()
    local file_path = vim.fn.expand('%:p')
    return vim.fn.fnamemodify(file_path, ':~' .. root)
end

local substitute = function(cmd)
    local root = git_root()
    local relative_path = relative_path_from_git_root()
    cmd = cmd:gsub('%%', vim.fn.expand '%')
    cmd = cmd:gsub('$fileBase', vim.fn.expand '%:r')
    cmd = cmd:gsub('$filePath', vim.fn.expand '%:p')
    cmd = cmd:gsub('$file', vim.fn.expand '%')
    cmd = cmd:gsub('$dir', vim.fn.expand '%:p:h')
    cmd = cmd:gsub('#', vim.fn.expand '#')
    cmd = cmd:gsub('$altFile', vim.fn.expand '#')
    cmd = cmd:gsub('$gitRoot', root)
    cmd = cmd:gsub('$relativePath', relative_path)
    print(cmd)

    return cmd
end

local run_code = function()
    local file_extension = vim.fn.expand '%:e'
    local selected_cmd = ''
    local term_cmd = 'bot 10 new | term cd ' .. git_root() .. ' && '
    local supported_filetypes = {
        c = { default = 'gcc % -o $fileBase && $fileBase', debug = 'gcc -g % -o $fileBase && $fileBase' },
        cpp = {
            default = 'g++ % -o  $fileBase && $fileBase',
            debug = 'g++ -g % -o  $fileBase',
            competitive = 'g++ -std=c++17 -Wall -DAL -O2 % -o $fileBase && $fileBase',
        },
        go = { default = 'go run %' },
        html = { default = 'firefox $filePath' },
        js = { default = 'node $relativePath' }, -- Use $relativePath for node command
        lua = { default = 'lua %' },
        py = { default = 'python3 %' },
        rs = { default = 'rustc % && $fileBase' },
        ts = { default = 'tsc % && node $fileBase' },
    }

    if supported_filetypes[file_extension] then
        local choices = vim.tbl_keys(supported_filetypes[file_extension])

        if #choices == 0 then
            vim.notify("It doesn't contain any command", vim.log.levels.WARN, { title = 'Code Runner' })
        elseif #choices == 1 then
            selected_cmd = supported_filetypes[file_extension][choices[1]]
            vim.cmd(term_cmd .. substitute(selected_cmd))
        else
            vim.ui.select(choices, { prompt = 'Choose a command: ' }, function(choice)
                selected_cmd = supported_filetypes[file_extension][choice]
                if selected_cmd then
                    vim.cmd(term_cmd .. substitute(selected_cmd))
                end
            end)
        end
    else
        vim.notify("The filetype isn't included in the list", vim.log.levels.WARN, { title = 'Code Runner' })
    end
end

vim.api.nvim_create_user_command('RunCode', function()
    run_code()
end, { desc = 'Neovim | Run Code' })
