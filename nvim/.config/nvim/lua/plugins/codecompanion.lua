return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      -- Change the default chat adapter
      chat = {
        adapter = "anthropic",
        slash_commands = {
          ["file"] = {
            opts = {
              provider = "fzf_lua",
            },
          },
          ["buffer"] = {
            opts = {
              provider = "fzf_lua",
            },
          },
        },
      },
      inline = {
        adapter = "anthropic",
      },
    },
  },
}
