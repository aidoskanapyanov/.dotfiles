return {
  "stevearc/oil.nvim",
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  keys = {
    {
      "<leader>fo",
      "<cmd>Oil<cr>",
      desc = "Oil explorer on current buffer directory",
    },
    -- {
    --   "<leader>fO",
    --   "<cmd>Oil .<cr>",
    --   { desc = "Oil explorer on current buffer directory" },
    -- },
  },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}
