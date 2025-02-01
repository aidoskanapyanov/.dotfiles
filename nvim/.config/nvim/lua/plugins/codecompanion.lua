return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  adapters = {
    anthropic = function()
      local api_key = os.getenv("ANTHROPIC_API_KEY")
      return require("codecompanion.adapters").extend("anthropic", {
        env = {
          api_key = api_key,
        },
      })
    end,
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
