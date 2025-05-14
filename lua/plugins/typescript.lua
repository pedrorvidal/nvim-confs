return {
  "jose-elias-alvarez/typescript.nvim",
  event = { "BufReadPre", "BufNewFile" },
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  config = function()
    local lspconfig = require("lspconfig")
    local ts = require("typescript")

    ts.setup({
      server = {
        on_attach = function(client, bufnr)
          -- Set keybindings
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
          end

          map("<leader>ai", ts.actions.addMissingImports, "Add Missing Imports")
          map("<leader>oi", ts.actions.organizeImports, "Organize Imports")
          map("<leader>ru", ts.actions.removeUnused, "Remove Unused Imports")
        end,
      },
    })
  end,
}
