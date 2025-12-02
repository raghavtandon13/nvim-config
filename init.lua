--[[ Lazy Setup ]]

require 'opts'
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    }
end
vim.opt.runtimepath:prepend(lazypath)
vim.o.guifont = 'JetBrainsMono Nerd Font:h11'
vim.g.neovide_title_background_color =
    string.format('%x', vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name 'Normal' }).bg)
vim.o.linespace = 12
vim.g.neovide_padding_top = 40

--[[ Imports ]]

require('lazy').setup({ { import = 'plugins' } }, {
    ui = { change_detection = { notify = false }, border = 'single' },

    performance = {
        rtp = {
            disabled_plugins = {
                '2html_plugin',
                'tohtml',
                'getscript',
                'getscriptPlugin',
                'gzip',
                'logipat',
                'netrw',
                'netrwPlugin',
                'netrwSettings',
                'netrwFileHandlers',
                'matchit',
                'tar',
                'tarPlugin',
                'rrhelper',
                'spellfile_plugin',
                'vimball',
                'vimballPlugin',
                'zip',
                'zipPlugin',
                'tutor',
                'rplugin',
                'syntax',
                'synmenu',
                'optwin',
                'compiler',
                'bugreport',
                'ftplugin',
                'man',
                'shada',
                'remote_plugins',
                'spellfile',
                'editorconfig',
            },
        },
    },
})
require 'keymaps'
require 'autos'
require 'highlights'
require 'utils'
