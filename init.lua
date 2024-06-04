--[[ Lazy Setup ]]

require 'opts'
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath }
end
vim.opt.runtimepath:prepend(lazypath)

--[[ Imports ]]

require('lazy').setup({ { import = 'plugins' } }, { ui = { change_detection = { notify = false }, border = 'single' } })
require 'keymaps'
require 'autos'
require 'highlights'
