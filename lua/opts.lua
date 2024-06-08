vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.wrap = false
vim.opt.conceallevel = 1
vim.opt.cursorline = true
-- vim.opt.relativenumber = false
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.title = true
vim.opt.titlestring = [[%t – %{fnamemodify(getcwd(), ':t')}]]
vim.opt.numberwidth = 4
vim.opt.shiftwidth = 4
vim.opt.fillchars = { eob = ' ' }
vim.opt.hls = false

vim.o.number = true
vim.wo.signcolumn = 'yes'
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.o.stc = ' %s %l  '
vim.o.laststatus = 3

vim.opt.shell = 'pwsh.exe'
vim.opt.shellxquote = ''
vim.opt.shellcmdflag = '-Command '
vim.opt.shellquote = ''
vim.opt.shellpipe = '| Out-File -Encoding UTF8 %s'
vim.opt.shellredir = '| Out-File -Encoding UTF8 %s'
