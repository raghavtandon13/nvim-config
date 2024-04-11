return {

  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
  { 'tpope/vim-sleuth' },
  { 'nvim-pack/nvim-spectre', otps = {} },
  { 'mg979/vim-visual-multi', branch = 'master' },
  { 'mbbill/undotree' },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
  { 'numToStr/Comment.nvim' },
  { 'famiu/bufdelete.nvim' },
  { 'kevinhwang91/nvim-ufo' },
  -- { 'nvim-treesitter/nvim-treesitter-context' },
  { 'folke/trouble.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, opts = {} },
  { 'windwp/nvim-autopairs', event = 'InsertEnter' },
  { 'Exafunction/codeium.nvim' },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  { 'folke/which-key.nvim', opts = {} },
}
