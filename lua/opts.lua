vim.filetype.add { extension = { ['http'] = 'http' } }
vim.g.db_ui_use_nvim_notify = 1
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.acd = true
vim.o.breakindent = true
vim.o.clipboard = 'unnamedplus'
vim.o.completeopt = 'menuone,noselect'
vim.o.foldcolumn = '1'
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.ignorecase = true
vim.o.laststatus = 3
vim.o.mouse = 'a'
vim.o.number = true
vim.o.smartcase = true
vim.o.stc = ' %s %l  '
vim.o.termguicolors = true
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.updatetime = 250
vim.opt.backup = false
vim.opt.conceallevel = 1
vim.opt.cursorline = true
vim.opt.fillchars = { eob = ' ' }
vim.opt.hls = false
vim.opt.numberwidth = 4
-- vim.opt.shell = '"C:\\Program Files\\PowerShell\\7\\pwsh.exe"'
vim.opt.shiftwidth = 4
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.title = true
vim.opt.titlestring = [[%t – %{fnamemodify(getcwd(), ':t')}]]
vim.opt.undofile = true
vim.opt.wrap = false
vim.wo.signcolumn = 'yes'
