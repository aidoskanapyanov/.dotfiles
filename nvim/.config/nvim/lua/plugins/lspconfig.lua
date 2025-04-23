return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pylsp = {
        -- Keep pylsp enabled for other features
        on_attach = function(client, _)
          -- Disable its definition and reference providers to avoid duplication
          client.server_capabilities.definitionProvider = false
          client.server_capabilities.referencesProvider = false
          client.server_capabilities.documentSymbolProvider = false
        end,
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
