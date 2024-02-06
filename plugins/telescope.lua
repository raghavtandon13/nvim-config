local actions = require("telescope.actions")
return {
  "telescope.nvim",
  config = function()
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-x>"] = actions.select_vertical,
          },
        },
      },
    })
  end,
}
