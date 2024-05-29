-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Remove carriage return
vim.keymap.set("n", "<leader>tc", function()
  vim.cmd(":%s/\r//")
end, { desc = "Remove carriage return" })
