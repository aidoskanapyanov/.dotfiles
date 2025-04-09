-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Set indent size for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "typescript",
    "javascript",
    "typescriptreact",
    "javascriptreact",
    "json",
    "yaml",
    "html",
    "css",
    "scss",
    "vue",
    "lua",
    "terraform",
  },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})
