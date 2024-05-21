-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {
  clear = true,
})
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
  pattern = { '*.*' },
  desc = 'save view (folds), when closing file',
  command = 'mkview',
})

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  pattern = { '*.*' },
  desc = 'load view (folds), when opening file',
  command = 'silent! loadview',
})

vim.api.nvim_create_augroup('alpha_on_empty', {
  clear = true,
})
vim.api.nvim_create_autocmd('User', {
  pattern = 'BDeletePre *',
  group = 'alpha_on_empty',
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(bufnr)

    if name == '' then
      vim.cmd [[:Neotree float]]
    end
  end,
})

local api = vim.api
local fn = vim.fn

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
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

api.nvim_create_augroup('WorkingDirectory', { clear = true })
api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = { '*.*' },
  callback = function()
    local path = fn.expand '%:h' .. '/'
    -- path = 'cd ' .. path
    path = 'cd ' .. find_git_root()
    api.nvim_command(path)
  end,
  group = 'WorkingDirectory',
})
-- ignore these filetypes
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Disable indentscope for certain filetypes',
  pattern = {
    'python',
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

-- Winbar no of windows > 1
-- local function set_winbar()
--   local num_windows = vim.fn.winnr '$'
--   if num_windows > 1 then
--     vim.opt.winbar = '%f'
--   else
--     vim.opt.winbar = ''
--   end
-- end
--
-- vim.api.nvim_create_augroup('WindowManagement', { clear = true })
-- vim.api.nvim_create_autocmd('WinEnter', {
--   group = 'WindowManagement',
--   callback = set_winbar,
-- })
-- vim.api.nvim_create_autocmd('WinLeave', {
--   group = 'WindowManagement',
--   callback = set_winbar,
-- })
-- vim.api.nvim_create_autocmd('WinResized', {
--   group = 'WindowManagement',
--   callback = set_winbar,
-- })
