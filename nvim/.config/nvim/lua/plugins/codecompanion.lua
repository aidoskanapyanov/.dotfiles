return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    adapters = {
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = {
            api_key = "cmd:grep '^ANTHROPIC_API_KEY=' ~/.dotfiles/.env | cut -d '=' -f2 | tr -d '\"'",
          },
          schema = { model = { default = "claude-3-7-sonnet-20250219" } },
        })
      end,
    },
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
  keys = {
    {
      "<leader>a",
      "<cmd>CodeCompanionChat Toggle<cr>",
      mode = { "v", "n" },
      noremap = true,
      silent = true,
      desc = "Open CodeCompanion",
    },
  },
}
