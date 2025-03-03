return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    textobjects = {
      move = {
        enable = true,
        goto_next_start = { ["]u"] = "@call.outer" },
        goto_previous_start = { ["[u"] = "@call.outer" },
      },
    },
  },
}
