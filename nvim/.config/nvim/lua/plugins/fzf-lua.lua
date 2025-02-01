return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  opts = {
    files = {
      fd_opts = [[--color=never --hidden --type f --type l --exclude .git --exclude venv --exclude .venv --exclude node_modules --exclude .next]],
      hidden = true,
      no_ignore = true,
    },
    grep = {
      hidden = true,
      no_ignore = true,
    },
  },
}
