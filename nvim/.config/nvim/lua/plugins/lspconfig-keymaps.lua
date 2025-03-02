return {
  "neovim/nvim-lspconfig",
  opts = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "gr", "<cmd>FzfLua lsp_references<cr>" }
  end,
}
