return {
  {
    "pwntester/octo.nvim",
    requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "nvim-tree/nvim-web-devicons" },
    cmd = "Octo",
    keys = {
      { "<leader>op", "<cmd>Octo pr list<cr>", desc = "List repo PRs" },
      { "<leader>oi", "<cmd>Octo issue list<cr>", desc = "List repo issues" },
      { "<leader>or", "<cmd>Octo repo list<cr>", desc = "List my repos" },
    },
    config = function()
      require("octo").setup()
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>o"] = { name = "+Octo" },
      },
    },
  },
}
