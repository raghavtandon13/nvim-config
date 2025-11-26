return {
    {
        'folke/which-key.nvim',
        keys = { '<leader>' },
        config = function()
            require('which-key').setup {
                preset = 'helix',
                expand = 1,
                win = { border = 'single' },
                icons = { mappings = false },
            }
            require('which-key').add {
                { '<leader>c', group = '[C]ode' },
                { '<leader>c_', hidden = true },
                { '<leader>g', group = '[G]it' },
                { '<leader>g_', hidden = true },
                { '<leader>b', group = '[B]uffer' },
                { '<leader>b_', hidden = true },
                { '<leader>h', group = 'Git [H]unk' },
                { '<leader>h_', hidden = true },
                { '<leader>r', group = '[R]ename' },
                { '<leader>r_', hidden = true },
                { '<leader>s', group = '[S]earch' },
                { '<leader>s_', hidden = true },
                { '<leader>t', group = '[T]oggle' },
                { '<leader>t_', hidden = true },
                { '<leader>w', group = '[W]orkspace' },
                { '<leader>w_', hidden = true },
                { '<leader>d', group = '[D]ebug Code' },
                { '<leader>d_', hidden = true },
                { '<leader>q', group = '[Q]uickfix List' },
                { '<leader>q_', hidden = true },
            }
            require('which-key').add {
                { '<leader>', group = 'VISUAL <leader>', mode = 'v' },
                { '<leader>g', desc = '[G]it', mode = 'v' },
            }
        end,
        keys = {
            {
                '<leader>?',
                function() require('which-key').show { global = false } end,
                desc = 'Buffer Local Keymaps (which-key)',
            },
        },
    },
}
