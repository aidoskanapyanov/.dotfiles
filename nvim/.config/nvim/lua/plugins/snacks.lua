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
    gitbrowse = {
      -- open = function(url)
      --   vim.system({ "wslview", url })
      -- end,
      url_patterns = {
        ["git.suresecure%.de"] = {
          branch = "/-/tree/{branch}",
          file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
          commit = "/-/commit/{commit}",
        },
      },
    },
    picker = {
      layout = {
        fullscreen = true,
      },
      sources = { lines = { layout = { fullscreen = false } } },
      previewers = { diff = { style = "terminal" } },
      formatters = {
        file = {
          truncate = 200, -- truncate the file path to (roughly) this length
        },
      },
    },
  },
}
