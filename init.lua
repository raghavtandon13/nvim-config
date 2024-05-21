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
vim.opt.rtp:prepend(lazypath)
require('lazy').setup { { import = 'plugins' } }
require 'keymaps'
require 'autos'
-- require 'lazyvim.util.telescope'
local function filter_tsserver_diagnostics(_, result, ctx, config)
  if result.diagnostics == nil then
    return
  end
  -- ignore some tsserver diagnostics
  local idx = 1
  while idx <= #result.diagnostics do
    local entry = result.diagnostics[idx]
    -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
    if entry.code == 80001 or entry.code == 80007 then
      -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
      table.remove(result.diagnostics, idx)
    else
      idx = idx + 1
    end
  end
  vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = filter_tsserver_diagnostics
