return {
  "stevearc/oil.nvim",
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  keys = {
    {
      "<leader>fo",
      "<cmd>Oil<cr>",
      desc = "Oil explorer on current buffer directory",
    },
  },
}
