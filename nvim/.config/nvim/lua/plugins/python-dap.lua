return {
  "mfussenegger/nvim-dap-python",
  config = function()
    if vim.fn.has("win32") == 1 then
      require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
    else
      require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/bin/python"))
    end

    -- Add Django-specific debugging configuration
    local dap = require("dap")
    table.insert(dap.configurations.python, {
      type = "python",
      request = "launch",
      name = "Django",
      program = vim.fn.getcwd() .. "/manage.py",
      args = { "runserver" },
    })

    -- chetwwood-testing
    table.insert(dap.configurations.python, {
      type = "python",
      request = "launch",
      name = "Debug Savings_QA2 Tests",
      program = "/home/aidos/dev/work/chetwood-testing/.venv/bin/execute-pytest",
      env = { PYTHONPATH = vim.fn.getcwd() },

      -- poetry run execute-pytest --config API_Security_Headers_X --target-env Savings_qa2 -r -c
      args = {
        "--config",
        "API_Security_Headers_X",
        "--target-env",
        "Savings_qa2",
        "-r",
        "-c",
      },
    })
  end,
}
