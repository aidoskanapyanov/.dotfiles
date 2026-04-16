return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pylsp = { enabled = false },
      pyright = {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
      yamlls = {
        settings = {
          yaml = {
            customTags = {
              -- These are all related to AWS CloudFormation.
              "!And sequence",
              "!Base64",
              "!Cidr sequence",
              "!Equals sequence",
              "!FindInMap sequence",
              "!GetAZs",
              "!GetAtt",
              "!If sequence",
              "!ImportValue",
              "!Join sequence",
              "!Length sequence",
              "!Not sequence",
              "!Or sequence",
              "!Ref",
              "!Select sequence",
              "!Split sequence",
              "!Sub",
              "!Transform scalar",
            },
          },
        },
      },
    },
  },
}
