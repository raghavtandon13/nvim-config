return {
    {
        'mfussenegger/nvim-dap', -- Main dap plugin
        enabled = false,
        dependencies = {
            'rcarriga/nvim-dap-ui', -- Dap UI Plugin
            'nvim-neotest/nvim-nio', -- Dap UI requiremnet
            'theHamsta/nvim-dap-virtual-text', -- Dap VirtualText Plugin
            'mfussenegger/nvim-dap-python', -- Dap adapter for Python
        },

        config = function()
            -- [[ Setting up DAP and DAP-UI ]]
            local dap = require 'dap'
            local wezterm_path = 'C:/Users/ragha/scoop/apps/wezterm/current/wezterm-gui.exe'
            dap.defaults.fallback.external_terminal = {
                command = wezterm_path,
                args = { 'start' },
            }
            local ui = require 'dapui'
            require('nvim-dap-virtual-text').setup {}
            require('dapui').setup {
                controls = {
                    element = 'scopes',
                    enabled = true,
                    icons = {
                        disconnect = '',
                        pause = '',
                        play = '',
                        run_last = '',
                        step_back = '',
                        step_into = '',
                        step_out = '',
                        step_over = '',
                        terminate = '',
                    },
                    element_mappings = {},
                },
                expand_lines = true,
                floating = { border = 'single', mappings = { close = { 'q', '<Esc>' } } },
                force_buffers = true,
                icons = { collapsed = '', current_frame = '', expanded = '' },
                layouts = { { elements = { { id = 'scopes', size = 0.25 } }, position = 'left', size = 40 } },
                mappings = {
                    edit = 'e',
                    expand = { '<CR>', '<2-LeftMouse>' },
                    open = 'o',
                    remove = 'd',
                    repl = 'r',
                    toggle = 't',
                },
                render = { indent = 1, max_value_lines = 100 },
            }
            --[[ Setting up Adapters and Configurations ]]

            -- Python Adapter and Configuration
            local path = '~/AppData/Local/nvim-data/mason/packages/debugpy/venv/Scripts/python.exe'
            require('dap-python').setup(path)

            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = 'Launch file',
                    program = '${file}',
                },
            }

            -- JavaScript Adapter and Configuration
            require('dap').adapters['pwa-node'] = {
                type = 'server',
                host = 'localhost',
                port = '${port}',
                -- Adapter at Downloads/webdev
                executable = {
                    command = 'node',
                    args = { 'C:/Users/ragha/Downloads/webdev/js-debug/src/dapDebugServer.js', '${port}' },
                },
            }
            require('dap').configurations.javascript = {
                {
                    type = 'pwa-node',
                    request = 'launch',
                    name = 'Launch file',
                    program = '${file}',
                    cwd = '${workspaceFolder}',
                },
            }
            -- [[ Keymaps and Options ]]
            vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'red', linehl = '', numhl = '' })
            vim.keymap.set('n', '<space>gb', dap.run_to_cursor)
            vim.keymap.set('n', '<space>b', dap.toggle_breakpoint)
            vim.keymap.set('n', '<space>?', function()
                require('dapui').eval(nil, { enter = true })
            end)
            vim.keymap.set('n', '<F1>', dap.continue)
            vim.keymap.set('n', '<F2>', dap.step_into)
            vim.keymap.set('n', '<F3>', dap.step_over)
            vim.keymap.set('n', '<F4>', dap.step_out)
            vim.keymap.set('n', '<F5>', dap.step_back)
            vim.keymap.set('n', '<F13>', dap.restart)
            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end
        end,
    },
}
