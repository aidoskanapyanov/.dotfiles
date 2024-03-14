return {
  "mfussenegger/nvim-dap",
  opts = function()
    local dap = require("dap")
    dap.defaults.python.exception_breakpoints = { "uncaught" }
  end,
}
