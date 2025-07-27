-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Remove carriage return
vim.keymap.set("n", "<leader>xc", function()
  vim.cmd([[:%s/\r//ge]])
end, { desc = "Remove carriage return" })

-- Rename tag (html/jsx/tsx etc)
vim.keymap.set("n", "<leader>ct", "", {
  desc = "Rename tag (html/jsx/tsx etc)",
  noremap = true,
  silent = true,
  callback = function()
    local newtag = vim.fn.input("Enter new tag name: ")
    local return_position = vim.api.nvim_win_get_cursor(0)

    vim.cmd([[execute "normal T<"]])

    -- check if the character is slash
    -- i.e. if it is a closing tag
    -- and if yes, move the cursor to the opening tag
    -- I dunno why, but it just works better when we change the opening tag first
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local char = vim.api.nvim_get_current_line():sub(col + 1, col + 1)

    if char == "/" then
      vim.cmd([[execute "normal %"]])
    end

    -- store the current cursor position
    local current_position = vim.api.nvim_win_get_cursor(0)

    -- go to the closing tab and move one character to the right, so that we can change the tag name
    vim.cmd([[execute "normal %l"]])

    vim.cmd('execute "normal \\"_ciw' .. newtag .. '"')

    -- go to current_position
    vim.api.nvim_win_set_cursor(0, current_position)

    -- change this tag as well
    vim.cmd('execute "normal \\"_ciw' .. newtag .. '"')

    -- return to return_position
    vim.api.nvim_win_set_cursor(0, return_position)
  end,
})

-- Jumping to context (upwards)
vim.keymap.set("n", "[x", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true, desc = "Jump up to context" })

-- Kubectl.nvim
vim.keymap.set(
  "n",
  "<leader>k",
  '<cmd>lua require("kubectl").toggle()<cr>',
  { noremap = true, silent = true, desc = "Open kubectl.nvim" }
)

-- git-worktree telescope finder keymaps
-- vim.keymap.set(
--   "n",
--   "<leader>sv",
--   "<cmd>lua require('telescope').extensions.git_worktree.git_worktree()<cr>",
--   { silent = true, desc = "git-worktree" }
-- )
-- vim.keymap.set(
--   "n",
--   "<leader>sV",
--   "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
--   { silent = true, desc = "create_git_worktree" }
-- )

vim.cmd([[cab cc CodeCompanionChat]])

vim.cmd([[cab gr term gh run list -w]])
vim.cmd([[cab grl term PAGER="less -FX" gh run view --log]])
vim.cmd([[cab gjl term PAGER="less -FX" gh run view --log --job]])
vim.cmd([[cab grv term gh run view -w]])

vim.cmd([[cab tic !xdg-open https://chetwood.atlassian.net/browse/]])

vim.keymap.set("n", "<leader>xv", "<cmd>LazyExtras<cr>", { noremap = true, silent = true, desc = "Open LazyExtras" })

vim.keymap.set("n", "<leader>cL", "<cmd>LspRestart<cr>", { noremap = true, silent = true, desc = "Restart LSP" })

vim.keymap.set("n", "<leader>y", function()
  local filepath = vim.fn.fnamemodify(vim.fn.expand("%"), ":.") -- Get relative path
  vim.fn.setreg(vim.v.register, filepath)
  require("noice").notify("Copied: " .. filepath, "info")
end, { desc = "Copy relative filename" })

-- FzfLua keymaps
vim.keymap.set(
  "n",
  "<leader>fd",
  "<cmd>FzfLua dap_breakpoints<cr>",
  { noremap = true, silent = true, desc = "FzfLua breakpoints" }
)

-- Open urls with wslview
local function is_url(text)
  return text:match("^https?://") ~= nil
end

-- Function to open URL under cursor
local function open_url()
  local cursor_word = vim.fn.expand("<cfile>")
  if is_url(cursor_word) then
    vim.fn.system(string.format('wslview "%s"', cursor_word))
  end
end

-- Map gx to open URLs
vim.keymap.set("n", "gx", open_url, { noremap = true, silent = true })
vim.keymap.set("v", "gx", open_url, { noremap = true, silent = true })
