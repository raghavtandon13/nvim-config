return {
  'sainnhe/gruvbox-material',
  config = function()
    vim.g.gruvbox_material_background = 'hard'
    vim.g.gruvbox_material_foreground = 'material'
    vim.g.gruvbox_material_transparent_background = 2
    vim.cmd [[colorscheme gruvbox-material]]
    if vim.g.neovide then
      vim.g.gruvbox_material_transparent_background = 0
    end
  end,
}
-- return {
--   'folke/tokyonight.nvim',
--   config = function()
--     vim.cmd [[colorscheme tokyonight-night]]
--   end,
--   lazy = false,
--   priority = 1000,
--   opts = {},
-- }
