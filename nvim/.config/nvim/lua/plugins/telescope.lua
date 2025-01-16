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
          find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
        },
        grep_string = {
          additional_args = { "--hidden" },
        },
        live_grep = {
          additional_args = { "--hidden" },
        },
      },
      extensions = {
        "fzf",
      },
    })
    telescope.load_extension("fzf")
  end,
}
