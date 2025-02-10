return {
  {
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "ibhagwan/fzf-lua",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Octo",
    keys = {
      { "<leader>gop", "<cmd>Octo pr list<cr>", desc = "List repo PRs" },
      { "<leader>goi", "<cmd>Octo issue list<cr>", desc = "List repo issues" },
      { "<leader>gor", "<cmd>Octo repo list<cr>", desc = "List my repos" },
    },
    config = function()
      require("octo").setup({
        picker = "fzf-lua",
      })
    end,
  },
}
