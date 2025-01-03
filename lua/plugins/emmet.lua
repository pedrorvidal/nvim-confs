return {
  {
    "mattn/emmet-vim",
    event = "VeryLazy",
    init = function()
      -- Enable Emmet globally
      vim.g.user_emmet_install_global = 1

      -- Ensure Emmet is explicitly installed for specific filetypes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "html",
          "css",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "php",
          "twig",
          "blade",
        },
        callback = function()
          -- Ensure Emmet is loaded and available for these filetypes
          vim.cmd("EmmetInstall")
        end,
      })

      -- Additional settings for better integration
      vim.g.user_emmet_mode = "a" -- enable all functions in all modes
      vim.g.user_emmet_settings = {
        variables = {
          lang = "en",
        },
        javascript = {
          extends = "jsx",
        },
        typescript = {
          extends = "tsx",
        },
      }
    end,
    config = function()
      -- Map CTRL+E directly to Emmet expansion
      vim.keymap.set("i", "<C-e>", "<plug>(emmet-expand-abbr)", { silent = true })
      vim.keymap.set("n", "<C-e>", "<plug>(emmet-expand-abbr)", { silent = true })
      vim.keymap.set("v", "<C-e>", "<plug>(emmet-expand-abbr)", { silent = true })
    end,
  },
}
