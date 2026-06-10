-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.tabstop = 4 -- A TAB character looks like 4 spaces
opt.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
opt.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
opt.shiftwidth = 4 -- Number of spaces inserted when indenting

vim.g.root_spec = { "cwd" }

vim.g.ai_cmp = false

vim.g.lazyvim_blink_main = true

vim.g.lazyvim_picker = "snacks"

-- disable autoformatting when saving a file
vim.g.autoformat = false

-- custom filetypes
vim.filetype.add({
  extension = {
    psql = "sql",
    pgsql = "sql",
  },
})


-- Sync Neovim yank/paste with the system clipboard using OSC 52
vim.opt.clipboard = "unnamedplus"

-- Only force OSC 52 when there's no native clipboard tool
-- (i.e. inside the devcontainer). On the host, let nvim use pbcopy/pbpaste.
if vim.fn.executable("pbpaste") == 0 and vim.fn.executable("xclip") == 0 then
  local osc52 = require("vim.ui.clipboard.osc52")
  vim.g.clipboard = {
    name = "OSC 52",
    copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
    paste = { ["+"] = osc52.paste("+"), ["*"] = osc52.paste("*") },
  }
end
