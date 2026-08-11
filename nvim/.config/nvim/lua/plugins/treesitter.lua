return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  opts = {
    move = {
      keys = {
        goto_next_start = { ["]u"] = "@call.outer" },
        goto_previous_start = { ["[u"] = "@call.outer" },
      },
    },
  },
}
