return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        htmldjango = { "djlint" },
        python = { "ruff_format", "ruff_organize_imports", "isort", "black" },
        markdown = { "prettier" },
        sql = { "sql_formatter" },
      },
      formatters = {
        -- TODO: use .config/sql_formatter.json file instead
        sql_formatter = {
          -- SQL Formatter options
          args = {
            "--config",
            vim.fn.json_encode({
              tabWidth = 4,
            }),
          },
        },
      },
      default_format_opts = {
        timeout_ms = 30000,
      },
    },
  },
}
