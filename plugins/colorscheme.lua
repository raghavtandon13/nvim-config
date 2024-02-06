return {
  -- {
  --   "rebelot/kanagawa.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("kanagawa").setup({
  --       compile = false,
  --       undercurl = true,
  --       commentStyle = { italic = true },
  --       functionStyle = {},
  --       keywordStyle = { italic = true },
  --       statementStyle = { bold = true },
  --       typeStyle = {},
  --       transparent = false,
  --       dimInactive = false,
  --       terminalColors = true,
  --       colors = {
  --         palette = {},
  --         theme = {
  --           wave = {},
  --           lotus = {},
  --           dragon = {},
  --           all = {
  --             ui = {
  --               bg_gutter = "none",
  --             },
  --           },
  --         },
  --       },
  --       overrides = function(colors)
  --         return {}
  --       end,
  --       theme = "wave",
  --       background = {
  --         dark = "dragon",
  --         light = "lotus",
  --       },
  --     })
  --
  --     vim.cmd("colorscheme kanagawa")
  --   end,
  -- },
  {
    "rose-pine/neovim",
    config = function()
      require("rose-pine").setup({
        styles = {
          bold = true,
          italic = true,
          transparency = false,
        },
      })
      vim.cmd("colorscheme rose-pine")
    end,
  },
  -- {
  --   "projekt0n/github-nvim-theme",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("github-theme").setup({
  --       -- ...
  --     })
  --
  --     -- vim.cmd("colorscheme rose-pine")
  --   end,
  -- },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "rose-pine",
  --   },
  -- },
  -- {
  --   "folke/tokyonight.nvim",
  --   -- opts = {
  --   --   transparent = true,
  --   --   styles = {
  --   --     sidebars = "transparent",
  --   --     floats = "transparent",
  --   --   },
  --   -- },
  -- },
}
