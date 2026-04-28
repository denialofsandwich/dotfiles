return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          on_attach = function(client, _)
            client.server_capabilities.codeActionProvider = false
          end,
        },
      },
    },
  },
}
