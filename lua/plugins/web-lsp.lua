-- LSP servers that don't have a dedicated LazyVim extra in this version:
-- html, cssls, jsonls, bashls, emmet_language_server
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {},
        cssls = {},
        jsonls = {},
        bashls = {},
        -- Emmet: modern, actively maintained LSP (npm: @olrtg/emmet-language-server)
        emmet_language_server = {
          filetypes = {
            "html",
            "blade",
            "php",
            "css",
            "javascriptreact",
            "typescriptreact",
          },
        },
      },
    },
  },
}
