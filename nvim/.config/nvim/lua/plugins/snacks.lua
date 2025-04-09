return {
  "folke/snacks.nvim",
  opts = {
    lazygit = {
      win = {
        width = 0,
        height = 0,
      },
    },
    scroll = {
      enabled = false,
    },
    indent = {
      animate = {
        enabled = false,
      },
    },
    bigfile = { enabled = true },
    picker = {
      layout = {
        fullscreen = true,
      },
      sources = { lines = { layout = { fullscreen = false } } },
      previewers = { git = { native = true } },
    },
  },
}
