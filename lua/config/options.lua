-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Use Intelephense (not the LazyVim default phpactor) for the `lang.php` extra
vim.g.lazyvim_php_lsp = "intelephense"

-- Recognize Laravel Blade templates as their own filetype
vim.filetype.add({
  pattern = {
    [".*%.blade%.php"] = "blade",
  },
})

-- Recognize .env files (.env, .env.local, .env.example, ...) with readable highlighting
vim.filetype.add({
  filename = {
    [".env"] = "sh",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "sh",
  },
})
