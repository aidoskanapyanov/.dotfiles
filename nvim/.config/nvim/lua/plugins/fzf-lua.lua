return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  opts = function()
    local actions = require("fzf-lua").actions
    local common_actions = {
      ["ctrl-y"] = actions.file_edit,
    }

    return {
      winopts = { fullscreen = true },
      files = {
        fd_opts = [[--color=never --hidden --type f --type l --exclude .git --exclude venv --exclude .venv --exclude node_modules --exclude .next --exclude __pycache__]],
        actions = common_actions,
      },
      git = {
        files = { actions = common_actions },
        status = { actions = common_actions },
      },
      grep = { actions = common_actions },
      lsp = { symbols = { actions = common_actions } },
      oldfiles = { actions = common_actions },
      quickfix = { actions = common_actions },
      loclist = { actions = common_actions },
    }
  end,
}
