local colors = {
  blue = "#80a0ff",
  cyan = "#79dac8",
  black = "#080808",
  white = "#c6c6c6",
  red = "#ff5189",
  violet = "#d183e8",
  ok1 = "#191724",
  ok = "#00FFFFFF",
  ok2 = "#332f4a",
  grey = "#303030",
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.ok },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}
local icons = require("lazyvim.config").icons
local Util = require("lazyvim.util")
return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = bubbles_theme,
      component_separators = "|",
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          -- separator = { left = "" }, right_padding = 2
        },
      },
      lualine_b = {
        -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        -- Util.lualine.root_dir(),
        -- { Util.lualine.pretty_path() },
        "branch",
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        {
          "diff",
          symbols = {
            added = icons.git.added,
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
      lualine_y = {
        -- "filetype"
      },
      lualine_z = {
        {
          "buffers",
          symbols = {
            modified = " ●", -- Text to show when the buffer is modified
            alternate_file = "", -- Text to show to identify the alternate file
            directory = "", -- Text to show when the buffer is a directory
          },
          -- filetype_names = {
          --   neoTree = "Tree",
          -- },
          --   { "location", separator = { right = "" }, left_padding = 2 },
        },
      },
    },
    inactive_sections = {
      lualine_a = { "filename" },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { "location" },
    },
    tabline = {},
    extensions = { "neo-tree", "lazy" },
  },
}
