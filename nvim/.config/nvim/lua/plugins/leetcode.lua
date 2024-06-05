return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- required by telescope
    "MunifTanjim/nui.nvim",

    -- optional
    "nvim-treesitter/nvim-treesitter",
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    lang = "python3",
  },
  keys = {
    { "<leader>cko", "<cmd>Leet<cr>", desc = "Open (leetcode.nvim)" },
    { "<leader>ckl", "<cmd>Leet lang<cr>", desc = "Choose language (leetcode.nvim)" },
    { "<leader>ckt", "<cmd>Leet test<cr>", desc = "Run tests (leetcode.nvim)" },
    { "<leader>cks", "<cmd>Leet submit<cr>", desc = "Submit solution (leetcode.nvim)" },
    { "<leader>ckc", "<cmd>Leet console<cr>", desc = "Open console (leetcode.nvim)" },
  },
}
