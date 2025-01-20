return {
  "nvim-telescope/telescope.nvim",
  -- opts = {
  --   defaults = {
  --     path_display = { "smart" },
  --   },
  -- },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      pickers = {
        find_files = {
          find_command = {
            "rg",
            "--files",
            "--glob=!**/.git/*",
            "--glob=!**/.venv/*",
            "--glob=!**/venv/*",
            "--hidden",
            "--no-ignore",
          },
        },
        grep_string = {
          additional_args = { "--hidden" },
        },
        live_grep = {
          additional_args = {
            "--glob=!**/.git/*",
            "--glob=!**/.venv/*",
            "--glob=!**/venv/*",
            "--hidden",
            "--no-ignore",
          },
        },
      },
      extensions = {
        "fzf",
      },
    })
    telescope.load_extension("fzf")
  end,
}
