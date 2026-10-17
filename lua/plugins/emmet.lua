-- Ctrl+E expands emmet abbreviations (VS Code style), via emmet-vim.
-- emmet_language_server (web-lsp.lua) keeps providing completion suggestions.
return {
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "scss", "php", "blade", "javascriptreact", "typescriptreact", "vue", "svelte" },
    init = function()
      vim.g.user_emmet_mode = "i" -- insert mode only, keeps normal-mode <C-e> scrolling
      vim.g.user_emmet_expandabbr_key = "<C-e>"
      vim.g.user_emmet_leader_key = "<C-z>" -- move other emmet maps off <C-y> (blink accept)
      vim.g.user_emmet_settings = {
        javascriptreact = { extends = "jsx" },
        typescriptreact = { extends = "jsx" },
      }
    end,
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<C-e>"] = false, -- blink uses <C-e> to hide the menu; free it for emmet
      },
    },
  },
}
