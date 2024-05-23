vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.wrap = false
vim.opt.conceallevel = 1
vim.opt.cursorline = true
vim.opt.relativenumber = false
vim.opt.splitright = true
vim.opt.guifont = 'Hurmit Nerd Font:h12'
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.title = true
vim.opt.titlestring = [[%t – %{fnamemodify(getcwd(), ':t')}]]
vim.opt.numberwidth = 4
vim.opt.shiftwidth = 4
vim.opt.fillchars = { eob = ' ' }
vim.opt.hls = false

vim.wo.number = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

vim.o.stc = ' %s %l  '
vim.o.laststatus = 3

vim.on_key(function(char)
    if vim.fn.mode() == 'n' then
        local new_hlsearch = vim.tbl_contains({ '<CR>', 'n', 'N', '*', '#', '?', '/' }, vim.fn.keytrans(char))
        if vim.opt.hlsearch:get() ~= new_hlsearch then
            vim.opt.hlsearch = new_hlsearch
        end
    end
end, vim.api.nvim_create_namespace 'auto_hlsearch')
