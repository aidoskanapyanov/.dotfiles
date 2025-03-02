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
    },
  },
}
