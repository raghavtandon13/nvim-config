local colors = {
  blue = '#80a0ff',
  cyan = '#79dac8',
  black = '#080808',
  white = '#c6c6c6',
  red = '#ff5189',
  violet = '#d183e8',
  ok1 = '#191724',
  ok = '#00FFFFFF',
  ok2 = '#332f4a',
  grey = '#303030',
}
local bubbles_theme = {
  normal = {
    a = {
      fg = colors.black,
      bg = colors.violet,
    },
    b = {
      fg = colors.white,
      bg = colors.black,
    },
    c = {
      fg = colors.black,
      bg = colors.ok,
    },
  },
  insert = {
    a = {
      fg = colors.black,
      bg = colors.blue,
    },
  },
  visual = {
    a = {
      fg = colors.black,
      bg = colors.cyan,
    },
  },
  replace = {
    a = {
      fg = colors.black,
      bg = colors.red,
    },
  },
  inactive = {
    a = {
      fg = colors.white,
      bg = colors.black,
    },
    b = {
      fg = colors.white,
      bg = colors.black,
    },
    c = {
      fg = colors.white,
      -- bg = colors.black,
    },
  },
}
local icons = {
  diagnostics = {
    Error = ' ',
    Warn = ' ',
    Hint = ' ',
    Info = ' ',
  },
  git = {
    added = ' ',
    modified = ' ',
    removed = ' ',
  },
}
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- [[ Install `lazy.nvim` plugin manager ]]
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
local powershell_options = {
  shell = vim.fn.executable 'pwsh' == 1 and 'pwsh' or 'powershell',
  shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
  shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait',
  shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
  shellquote = '',
  shellxquote = '',
}

for option, value in pairs(powershell_options) do
  vim.opt[option] = value
end
-- [[ Configure plugins ]]
require('lazy').setup({
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        config = true,
      },
      'williamboman/mason-lspconfig.nvim',
      -- {
      --   'j-hui/fidget.nvim',
      --   opts = {
      --     notification = {
      --       window = {
      --         winblend = 0,
      --       }
      --     }
      --   }
      -- },
      'folke/neodev.nvim',
    },
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step fails on windows
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
    'folke/which-key.nvim',
    opts = {},
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = {
          text = '+',
        },
        change = {
          text = '~',
        },
        delete = {
          text = '_',
        },
        topdelete = {
          text = '‾',
        },
        changedelete = {
          text = '~',
        },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, {
          expr = true,
          desc = 'Jump to next hunk',
        })

        map({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, {
          expr = true,
          desc = 'Jump to previous hunk',
        })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, {
          desc = 'stage git hunk',
        })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, {
          desc = 'reset git hunk',
        })
        -- normal mode
        map('n', '<leader>hs', gs.stage_hunk, {
          desc = 'git stage hunk',
        })
        map('n', '<leader>hr', gs.reset_hunk, {
          desc = 'git reset hunk',
        })
        map('n', '<leader>hS', gs.stage_buffer, {
          desc = 'git Stage buffer',
        })
        map('n', '<leader>hu', gs.undo_stage_hunk, {
          desc = 'undo stage hunk',
        })
        map('n', '<leader>hR', gs.reset_buffer, {
          desc = 'git Reset buffer',
        })
        map('n', '<leader>hp', gs.preview_hunk, {
          desc = 'preview git hunk',
        })
        map('n', '<leader>hb', function()
          gs.blame_line {
            full = false,
          }
        end, {
          desc = 'git blame line',
        })
        map('n', '<leader>hd', gs.diffthis, {
          desc = 'git diff against index',
        })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, {
          desc = 'git diff against last commit',
        })

        -- Toggles
        map('n', '<leader>tb', gs.toggle_current_line_blame, {
          desc = 'toggle git blame line',
        })
        map('n', '<leader>td', gs.toggle_deleted, {
          desc = 'toggle git show deleted',
        })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {
          desc = 'select git hunk',
        })
      end,
    },
  },
  {
    -- 'projekt0n/github-nvim-theme',
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --   require('github-theme').setup {
    --     options = {
    --       transparent = true,
    --     },
    --   }
    --   vim.cmd [[colorscheme github_dark_default]]
    -- end,
  },
  {
    -- 'catppuccin/nvim',
    -- name = 'catppuccin',
    -- priority = 1000,
    -- config = function()
    --   require('catppuccin').setup {
    --     flavour = 'mocha',
    --     transparent_background = true,
    --   }
    --   vim.cmd [[colorscheme catppuccin]]
    -- end,
  },

  {
    -- "HERE",
    -- config = function()
    --   require('HERE').setup {
    --     options = {
    --       transparent = true,
    --     },
    --   }
    --   vim.cmd [[colorscheme HERE]]
    -- end,
  },
  {
    -- 'folke/tokyonight.nvim',
    -- config = function()
    --   require('tokyonight').setup {
    --     style = 'night',
    --     transparent = true,
    --   }
    --   vim.cmd [[colorscheme tokyonight]]
    -- end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        dim_inactive_windows = false,
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
        highlight_groups = {
          ['String'] = { fg = '#dfdbf2' },
        },
      }
      vim.cmd [[colorscheme rose-pine-main]]
    end,
  },
  { 'kevinhwang91/nvim-ufo' },
  {
    'ellisonleao/glow.nvim',
    config = true,
    cmd = 'Glow',
  },
  { 'nvim-treesitter/nvim-treesitter-context' },
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.startify'

      dashboard.section.header.val = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
      }
      alpha.setup(dashboard.opts)
    end,
  },
  ------------------------------------------------------------
  ------------------------------------------------------------
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
  ------------------------------------------------------------
  ------------------------------------------------------------
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  ------------------------------------------------------------
  ------------------------------------------------------------
  {
    'brenton-leighton/multiple-cursors.nvim',
    config = true,
    keys = {
      {
        '<C-Down>',
        '<Cmd>MultipleCursorsAddDown<CR>',
        mode = { 'n', 'i' },
      },
      { '<C-j>', '<Cmd>MultipleCursorsAddDown<CR>' },
      {
        '<C-Up>',
        '<Cmd>MultipleCursorsAddUp<CR>',
        mode = { 'n', 'i' },
      },
      { '<C-k>', '<Cmd>MultipleCursorsAddUp<CR>' },
      {
        '<C-LeftMouse>',
        '<Cmd>MultipleCursorsMouseAddDelete<CR>',
        mode = { 'n', 'i' },
      },
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {}, -- this is equalent to setup({}) function
  },
  {
    'rest-nvim/rest.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('rest-nvim').setup {
        -- Open request results in a horizontal split
        result_split_horizontal = false,
        -- Keep the http file buffer above|left when split horizontal|vertical
        result_split_in_place = false,
        -- stay in current windows (.http file) or change to results window (default)
        stay_in_current_window_after_split = false,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = false,
        -- Encode URL before making request
        encode_url = true,
        -- Highlight request on run
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          -- toggle showing URL, HTTP info, headers at top the of result window
          show_url = true,
          -- show the generated curl command in case you want to launch
          -- the same request via the terminal (can be verbose)
          show_curl_command = true,
          show_http_info = true,
          show_headers = true,
          -- table of curl `--write-out` variables or false if disabled
          -- for more granular control see Statistics Spec
          show_statistics = false,
          -- executables or functions for formatting response body [optional]
          -- set them to false if you want to disable them
          formatters = {
            json = 'jq',
            html = function(body)
              return vim.fn.system({ 'tidy', '-i', '-q', '-' }, body)
            end,
          },
        },
        -- Jump to request line on run
        jump_to_request = false,
        env_file = '.env',
        -- for telescope select
        env_pattern = '\\.env$',
        env_edit_command = 'tabedit',
        custom_dynamic_variables = {},
        yank_dry_run = true,
        search_back = true,
      }
    end,
  },
  ------------------------------------------------------------
  {
    -- amongst your other plugins
    {
      'akinsho/toggleterm.nvim',
      version = '*',
      opts = {
        shell = vim.o.shell,
      },
    },
  },
  ------------------------------------------------------------
  {
    'epwalsh/obsidian.nvim',
    config = function()
      require('obsidian').setup {
        dir = 'D:/Notes',
        new_notes_location = 'notes_subdir',
        completion = {
          nvim_cmp = true,
          min_chars = 2,
        },
        mappings = {
          ['gf'] = {
            action = function()
              return require('obsidian').util.gf_passthrough()
            end,
            opts = {
              noremap = false,
              expr = true,
              buffer = true,
            },
          },
        },
        note_id_func = function(title)
          local suffix = ''
          if title ~= nil then
            suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
            return suffix
          else
            for _ = 1, 4 do
              suffix = suffix .. string.char(math.random(65, 90))
              return tostring(os.time()) .. '-' .. suffix
            end
          end
        end,
        image_name_func = function()
          return string.format('%s-', os.time())
        end,
        note_frontmatter_func = function() end,
      }
    end,
  },
  ------------------------------------------------------------
  ------------------------------------------------------------
  {
    'Exafunction/codeium.nvim',
    opts = {},
  },

  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = bubbles_theme,
        component_separators = '|',
        section_separators = {
          left = '',
          right = '',
        },
        disabled_filetypes = { 'alpha' },
      },
      sections = {
        lualine_a = { { 'mode' } },
        lualine_b = {

          'branch',
          {
            'diagnostics',
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          {
            'diff',
            symbols = {
              added = ' ',
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          {
            'buffers',
            symbols = {
              modified = ' ●',
              alternate_file = '',
              directory = '',
            },
          },
        },
      },
      extensions = { 'neo-tree', 'lazy' },
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
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
  { 'MunifTanjim/nui.nvim' },
  { 'famiu/bufdelete.nvim' },
  {
    'nvim-neo-tree/neo-tree.nvim',
    opts = {
      window = {
        position = 'right',
      },
    },
  },
  -- {    'echasnovski/mini.statusline',
  --   version = '*',
  --   config = function()
  --     require('mini.statusline').setup {
  --       -- Your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     }
  --   end},
  {
    'echasnovski/mini.move',
    version = '*',
    config = function()
      require('mini.move').setup {
        mappings = {
          -- Move visual selection in Visual mode.
          left = '<M-left>',
          right = '<M-right>',
          down = '<M-down>',
          up = '<M-up>',

          -- Move current line in Normal mode.
          line_left = '<M-left>',
          line_right = '<M-right>',
          line_down = '<M-down>',
          line_up = '<M-up>',
        },
      }
    end,
  },
  {
    -- 'echasnovski/mini.indentscope',
    -- version = '*',
    -- opts = {
    --   options = {
    --     -- border = 'both',
    --     -- indent_at_cursor = true,
    --   },
    -- },
  },
  -- {
  --   'NvChad/nvim-colorizer.lua',
  --   config = function()
  --     require('colorizer').setup {
  --       filetypes = { '*' },
  --       user_default_options = { tailwind = true },
  --     }
  --   end,
  -- },
  { 'nvim-pack/nvim-spectre', otps = {} },
  ------------------------------------------------------------
  ------------------------------------------------------------
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('conform').setup {
        notify_on_error = false,
        formatters_by_ft = {
          lua = { 'stylua' },
          javascript = { { 'prettierd', 'prettier' } },
          typescript = { { 'prettierd', 'prettier' } },
          javascriptreact = { { 'prettierd', 'prettier' } },
          typescriptreact = { { 'prettierd', 'prettier' } },
          html = { { 'prettierd', 'prettier' } },
          json = { { 'prettierd', 'prettier' } },
          markdown = { 'markdownlint' },
          go = { 'gofumpt' },
        },
      }
      vim.keymap.set('n', '<leader>mm', function()
        require('conform').format {
          lsp_fall = true,
          async = false,
          timeout_ms = 2000,
        }
      end)
    end,
  },
  {
    'chipsenkbeil/distant.nvim',
    branch = 'v0.3',
    config = function()
      require('distant'):setup()
    end,
  },
  {
    'nosduco/remote-sshfs.nvim',
    otps = {},
  },
  {
    'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = {
        markdown = { 'vale' },
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
      }
    end,
  },
  { 'mbbill/undotree' },
  { 'github/copilot.vim' },
  ------------------------------------------------------------
  ------------------------------------------------------------
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      -- scope = { enabled = true },
    },
  },
  {
    'numToStr/Comment.nvim',
    opts = {},
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
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate',
  }, -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',
  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

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
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {
  desc = 'Open diagnostics list',
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
    file_ignore_patterns = { 'node_modules' },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-x>'] = require('telescope.actions').select_vertical,
      },
    },
  },
}

-- Enable telescope fzf native
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
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, {
  desc = 'Search [G]it [F]iles',
})
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').find_files, {
  desc = '[S]earch [F]iles',
})
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
  -- tsserver = {},
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

vim.keymap.set({ 'n', 'i' }, '<S-Tab>', ':bNext<CR>', { silent = true })
vim.keymap.set('n', '<leader>os', ':ObsidianQuickSwitch<CR>')
vim.keymap.set('n', '<leader>og', ':ObsidianSearch<CR>')
vim.keymap.set('n', '<leader>on', ':ObsidianNew<CR>')

vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { silent = true })
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
      vim.cmd [[:Alpha]]
    end
  end,
})
vim.api.nvim_create_augroup('cdpwd', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  group = 'cdpwd',
  callback = function()
    vim.cmd('cd ' .. vim.fn.getcwd())
  end,
})
-- spectre mappings
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
vim.opt.conceallevel = 1
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.splitright = true
vim.opt.guifont = 'Hurmit Nerd Font:h12'
-- vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = '#d183e8', fg = 'black' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'black' })
vim.api.nvim_set_hl(0, '@ibl.scope.char.1', { fg = '' })
vim.keymap.set({ 'n' }, '<C-s>', ':w<CR>')
vim.keymap.set({ 'n' }, '<C-q>', ':TroubleToggle<CR>')
vim.keymap.set({ 'n' }, '<leader>ff', 'gg<S-v><S-g>y')
vim.keymap.set({ 'n' }, '<leader>l1', ':set rnu nu<CR>')
vim.keymap.set({ 'n' }, '<leader>l2', ':set nornu nonu<CR>')
vim.keymap.set({ 'n' }, '<leader>l3', ':set nornu nu<CR>')
vim.keymap.set({ 'n' }, '<leader>2', ':!wt -d .<CR>', { silent = true })
vim.keymap.set({ 'n' }, '<leader>3', ':!wt -w _quake -d .<CR>', { silent = true })
vim.keymap.set({ 'n' }, '<leader>4', ':!explorer .<CR>', { silent = true })
vim.keymap.set({ 'n' }, '<leader>fr', ':lua require("rest-nvim").run()<CR>', { silent = true })

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ''

-- local set_hl_for_floating_window = function()
--   vim.api.nvim_set_hl(0, 'NormalFloat', {
--     link = 'Normal',
--   })
--   vim.api.nvim_set_hl(0, 'FloatBorder', {
--     bg = '#080808',
--   })
-- end
--
-- set_hl_for_floating_window()
--
-- vim.api.nvim_create_autocmd('ColorScheme', {
--   pattern = '*',
--   desc = 'Avoid overwritten by loading color schemes later',
--   callback = set_hl_for_floating_window,
-- })
