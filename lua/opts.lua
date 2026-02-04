local sysname = vim.uv.os_uname().sysname
local os = sysname:match('Windows') and 'Windows' or sysname:match('Linux') and 'Linux' or sysname
local is_windows = os == 'Windows'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.acd = true
vim.o.breakindent = true
vim.o.clipboard = 'unnamedplus'
vim.o.completeopt = 'menuone,noselect'
vim.o.foldcolumn = '1'
vim.o.foldenable = true
vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = 'expr'
vim.o.ignorecase = true
vim.o.laststatus = 3
vim.o.mouse = 'a'
vim.o.number = true
vim.o.smartcase = true
vim.o.stc = ' %s %l   '
vim.o.termguicolors = true
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.updatetime = 250
vim.opt.backup = false
vim.opt.conceallevel = 1
vim.opt.cursorline = true
vim.opt.fillchars = { eob = ' ' }
vim.opt.foldcolumn = '0'
vim.opt.hls = false
vim.opt.lazyredraw = true
vim.opt.numberwidth = 4
vim.opt.shiftwidth = 4
vim.opt.shortmess:append('I')
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.title = true
vim.opt.ttimeoutlen = 10
vim.opt.undofile = true
vim.opt.wrap = false
vim.wo.signcolumn = 'yes'

if is_windows then
    vim.o.shell = 'pwsh'
    vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
    vim.o.shellquote = ''
    vim.o.shellxquote = ''
end

local global = {
    os = os,
    is_windows = is_windows,
    path_delimiter = is_windows and ';' or ':',
    path_separator = is_windows and '\\' or '/',
}

for name, value in pairs(global) do
    vim.g[name] = value
end
