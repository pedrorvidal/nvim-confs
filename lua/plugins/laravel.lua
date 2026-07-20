return {
  -- Treesitter: Blade grammar + a couple of extra parsers useful for Laravel work
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "blade",
        "css",
        "sql",
      },
    },
  },

  -- Intelephense: also attach to Blade files (they're PHP underneath the HTML)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          filetypes = { "php", "blade" },
        },
      },
    },
  },

  -- Formatting: prefer Laravel Pint, fall back to php-cs-fixer for non-Laravel PHP projects
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "pint", "php_cs_fixer", stop_after_first = true },
      },
    },
  },

  -- Linting: PHPStan static analysis, when a project provides it (vendor/bin/phpstan or global install)
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        php = { "phpstan" },
      },
      linters = {
        phpstan = {
          -- Skip running phpstan entirely when the project doesn't have it,
          -- instead of letting nvim-lint try (and fail with ENOENT) on every save.
          condition = function()
            return vim.uv.fs_stat(vim.fn.getcwd() .. "/vendor/bin/phpstan") ~= nil
              or vim.fn.executable("phpstan") == 1
          end,
        },
      },
    },
  },
}
