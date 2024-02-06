-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<leader>bd", bdelete)
vim.keymap.set("n", "<leader>bd", "<cmd>Bdelete<CR>")
vim.keymap.set("n", "<S-Tab>", "<cmd>bnext<CR>")
