return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        htmldjango = { "djlint" },
        python = { "ruff_format", "ruff_organize_imports", "isort", "black" },
        markdown = { "prettier" },
      },
      default_format_opts = {
        timeout_ms = 30000,
      },
    },
  },
}
