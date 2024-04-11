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

-- [[ Configure plugins ]]
require('lazy').setup({
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        config = true,
      },
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
    },
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'rafamadriz/friendly-snippets',
      {
        'roobert/tailwindcss-colorizer-cmp.nvim',
        config = function()
          require('tailwindcss-colorizer-cmp').setup {
            color_square_width = 2,
          }
        end,
      },
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      cmdline = {
        enabled = true,
        view = 'cmdline',
      },
      views = {
        mini = {
          win_options = {
            winblend = 0,
          },
        },
      },
    },
    dependencies = { 'MunifTanjim/nui.nvim' },
  },
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('telescope').load_extension 'lazygit'
    end,
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate',
  },
  { import = 'plugins' },
}, {})

-- [[ Basic Keymaps ]]

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', {
  silent = true,
})
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {
  expr = true,
  silent = true,
})
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {
  expr = true,
  silent = true,
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {
  desc = 'Go to previous diagnostic message',
})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {
  desc = 'Go to next diagnostic message',
})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {
  desc = 'Open floating diagnostic message',
})

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

-- [[ Configure Telescope ]]
require('telescope').setup {
  defaults = {
    file_ignore_patterns = { 'node_modules', 'build', 'dist', 'yarn.lock', '.spec.ts' },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-x>'] = require('telescope.actions').select_vertical,
      },
    },
  },
}

pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
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

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, {
  desc = '[?] Find recently opened files',
})
vim.keymap.set('n', '<leader>,', require('telescope.builtin').buffers, {
  desc = '[ ] Find existing buffers',
})
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, {
  desc = '[/] Fuzzily search in current buffer',
})

vim.keymap.set('n', '<leader><space>', function()
  require('telescope.builtin').find_files { layout_strategy = 'vertical', layout_config = { width = 0.8 } }
end, {
  desc = '[S]earch [F]iles',
})
local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, {
  desc = '[S]earch [/] in Open Files',
})
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, {
  desc = '[S]earch [S]elect Telescope',
})
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, {
  desc = '[S]earch [S]elect Telescope',
})
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, {
  desc = 'Search [G]it [F]iles',
})
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').find_files, {
--   desc = '[S]earch [F]iles',
-- })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, {
  desc = '[S]earch [H]elp',
})
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, {
  desc = '[S]earch current [W]ord',
})
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, {
  desc = '[S]earch by [G]rep',
})
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', {
  desc = '[S]earch by [G]rep on Git Root',
})
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, {
  desc = '[S]earch [D]iagnostics',
})
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, {
  desc = '[S]earch [R]esume',
})

-- [[ Configure Treesitter ]]
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'c',
      'cpp',
      'go',
      'lua',
      'python',
      'rust',
      'tsx',
      'javascript',
      'typescript',
      'vimdoc',
      'vim',
      'bash',
      -- 'markdown',
      'markdown_inline',
    },

    auto_install = false,
    sync_install = false,
    ignore_install = {},
    modules = {},
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- [[ Configure LSP ]]
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, {
      buffer = bufnr,
      desc = desc,
    })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', function()
    vim.lsp.buf.code_action {
      context = {
        only = { 'quickfix', 'refactor', 'source' },
      },
    }
  end, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, {
    desc = 'Format current buffer with LSP',
  })
end

require('which-key').register {
  ['<leader>c'] = {
    name = '[C]ode',
    _ = 'which_key_ignore',
  },
  ['<leader>d'] = {
    name = '[D]ocument',
    _ = 'which_key_ignore',
  },
  ['<leader>g'] = {
    name = '[G]it',
    _ = 'which_key_ignore',
  },
  ['<leader>h'] = {
    name = 'Git [H]unk',
    _ = 'which_key_ignore',
  },
  ['<leader>r'] = {
    name = '[R]ename',
    _ = 'which_key_ignore',
  },
  ['<leader>s'] = {
    name = '[S]earch',
    _ = 'which_key_ignore',
  },
  ['<leader>t'] = {
    name = '[T]oggle',
    _ = 'which_key_ignore',
  },
  ['<leader>w'] = {
    name = '[W]orkspace',
    _ = 'which_key_ignore',
  },
}

require('which-key').register({
  ['<leader>'] = {
    name = 'VISUAL <leader>',
  },
  ['<leader>h'] = { 'Git [H]unk' },
}, {
  mode = 'v',
})

require('mason').setup()
require('mason-lspconfig').setup()

local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  tsserver = {},
  html = {
    filetypes = { 'html', 'jsx', 'tsx' },
  },

  lua_ls = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        library = {
          '${3rd}/luv/library',
          unpack(vim.api.nvim_get_runtime_file('', true)),
        },
      },
      completion = {
        callSnippet = 'Replace',
      },
      telemetry = {
        enable = false,
      },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- [[ Configure nvim-cmp ]]
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered {
      winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
    },
    documentation = cmp.config.window.bordered {
      winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
    },
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  formatting = { format = require('tailwindcss-colorizer-cmp').formatter },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        fallback()
        -- cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        fallback()
        -- luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        fallback()
        -- cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        fallback()
        -- luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = { {
    name = 'nvim_lsp',
  }, {
    name = 'luasnip',
  }, {
    name = 'path',
  }, {
    name = 'codeium',
  } },
}

vim.keymap.set({ 'n' }, '<S-Tab>', ':bNext<CR>', { silent = true })
vim.keymap.set('n', '<leader>os', ':ObsidianQuickSwitch<CR>')
vim.keymap.set('n', '<leader>og', ':ObsidianSearch<CR>')
vim.keymap.set('n', '<leader>on', ':ObsidianNew<CR>')

vim.keymap.set('n', '<leader>e', ':Neotree toggle float<CR>', { silent = true })
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

vim.keymap.set('n', '<leader>bd', ':Bdelete<CR>', { silent = true })
vim.keymap.set('n', '<leader>bb', ':Bdelete<CR>', { silent = true })
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

vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = 'Toggle Spectre',
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = 'Search current word',
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = 'Search current word',
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = 'Search on current file',
})
-------------------------
-- vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = '#d183e8', fg = 'black' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffffff' })
vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = '#cfcfcf' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'black' })
vim.api.nvim_set_hl(0, '@ibl.scope.char.1', { fg = '' })
vim.keymap.set({ 'n' }, '<C-s>', ':w<CR>')
vim.keymap.set({ 'n' }, '<leader>q', ':TroubleToggle<CR>')
vim.keymap.set({ 'n' }, '<leader>ff', 'gg<S-v><S-g>y')
vim.keymap.set({ 'n' }, '<leader>l1', ':set rnu nu<CR>')
vim.keymap.set({ 'n' }, '<leader>l2', ':set nornu nonu<CR>')
vim.keymap.set({ 'n' }, '<leader>l3', ':set nornu nu<CR>')
vim.keymap.set({ 'n' }, '<leader>2', ':!wt -d .<CR>', { silent = true })
vim.keymap.set({ 'n' }, '<leader>3', ':!wt -w _quake -d .<CR>', { silent = true })
vim.keymap.set({ 'n' }, '<leader>4', ':!explorer .<CR>', { silent = true })
vim.keymap.set({ 'n' }, '<leader>fr', ':lua require("rest-nvim").run()<CR>', { silent = true })
vim.keymap.set('n', '<c-left>', ':bNext<CR>', { silent = true })
vim.keymap.set('n', '<c-right>', ':bnext<CR>', { silent = true })
if vim.g.neovide then
  vim.keymap.set('v', '<D-c>', '"+y')
  vim.keymap.set('n', '<D-v>', '"+P')
  vim.keymap.set('v', '<D-v>', '"+P')
  vim.keymap.set('n', '<D-s>', ':w<CR>')
  vim.keymap.set('c', '<D-v>', '<C-R>+')
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli')
end

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

require 'opts'
