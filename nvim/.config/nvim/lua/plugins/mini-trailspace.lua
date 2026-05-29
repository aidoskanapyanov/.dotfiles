return {
  -- usage: lua MiniTrailspace.trim()
  {
    "nvim-mini/mini.trailspace",
    version = "*",
    config = function()
      require("mini.trailspace").setup()
    end,
    init = function()
      vim.cmd("au FileType dashboard lua vim.b.minitrailspace_disable = true")
      vim.cmd("au FileType lazy lua vim.b.minitrailspace_disable = true")
    end,
    keys = {
      {
        "<leader>cw",
        function()
          require("mini.trailspace").trim()
        end,
        desc = "Trim trailing whitespaces",
      },
    },
  },
}
