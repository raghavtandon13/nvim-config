return {
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
    'sainnhe/gruvbox-material',
    config = function()
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_foreground = 'material'
      vim.g.gruvbox_material_transparent_background = 2
      vim.cmd [[colorscheme gruvbox-material]]
    end,
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
      -- vim.cmd [[colorscheme rose-pine-main]]
    end,
  },
}
