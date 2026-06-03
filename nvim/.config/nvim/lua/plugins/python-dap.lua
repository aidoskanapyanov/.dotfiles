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

    -- sls offline debugger
    table.insert(dap.configurations.python, {
      type = "python",
      request = "attach",
      name = "Attach to debugpy (sls offline)",
      connect = { host = "127.0.0.1", port = 5678 },
      env = { PYTHONPATH = vim.fn.getcwd() },
      pathMappings = {
        { localRoot = vim.fn.getcwd(), remoteRoot = "/home/aidos/dev/work/seagard-backend" },
      },
    })

    -- Wayflyer dev container (docker compose `dev` service)
    -- Host repo is bind-mounted at /workspace in the container via docker-compose.override.yml
    table.insert(dap.configurations.python, {
      type = "python",
      request = "attach",
      name = "Attach to debugpy (wayflyer dev container)",
      connect = { host = "127.0.0.1", port = 5678 },
      justMyCode = false,
      pathMappings = {
        { localRoot = vim.fn.getcwd(), remoteRoot = "/workspace" },
      },
    })
  end,
}
