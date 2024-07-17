return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
    end,
    keys = {
      { "<leader>re", "<cmd>Refactor extract<cr>", mode = "x", desc = "Extract" },
      { "<leader>rf", "<cmd>Refactor extract_to_file<cr>", mode = "x", desc = "Extract to file" },
      { "<leader>rv", "<cmd>Refactor extract_var<cr>", mode = "x", desc = "Extract var" },
      { "<leader>ri", "<cmd>Refactor inline_var<cr>", mode = { "n", "x" }, desc = "Inline var" },
      { "<leader>rI", "<cmd>Refactor inline_func<cr>", mode = "n", desc = "Inline func" },
      { "<leader>rb", "<cmd>Refactor extract_block<cr>", mode = "n", desc = "Extract block" },
      { "<leader>rbf", "<cmd>Refactor extract_block_to_file<cr>", mode = "n", desc = "Extract block to file" },
    },
  },
}
