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

-- WSL clipboard: win32yank preserves Windows CRLF, which shows up as trailing
-- ^M when pasting into nvim. Force LF on read and CRLF on write so paste/yank
-- stay clean in both directions. Only applies when win32yank.exe is actually
-- present (i.e. under WSL); elsewhere nvim falls back to its normal clipboard
-- detection (xclip/wl-copy on Linux, native win32 provider on Windows).
if vim.fn.executable("win32yank.exe") == 1 then
  vim.g.clipboard = {
    name = "win32yank-lf",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
end
