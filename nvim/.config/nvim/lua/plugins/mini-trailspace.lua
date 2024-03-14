return {
  {
    "echasnovski/mini.trailspace",
    version = "*",
    keys = {
      -- stylua: ignore
      {
        "<leader>tw",
        function() require("mini.trailspace").trim() end,
        desc = "Trim trailing whitespaces",
      },
    },
    opts = { only_in_normal_buffers = true },
  },
}
