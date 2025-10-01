return {
  -- Python language support (pyright LSP, ruff, dap, etc.)
  { import = "lazyvim.plugins.extras.lang.python" },

  -- Testing UI + neotest for python (pytest)
  { import = "lazyvim.plugins.extras.test.core" },
  { import = "lazyvim.plugins.extras.test.pytest" },

  -- Optional: task runner (great for "run this file")
  { import = "lazyvim.plugins.extras.util.overseer" },

  -- Formatter/Linter config with conform.nvim & ruff
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format" }, -- fast: ruff handles both
      },
    },
  },

  -- If you prefer black instead of ruff_format, use:
  -- {
  --   "stevearc/conform.nvim",
  --   opts = { formatters_by_ft = { python = { "ruff_fix", "black" } } },
  -- },

  -- Ensure tools installed via Mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "pyright", -- LSP
        "ruff", -- CLI for ruff
        "ruff-lsp", -- LSP wrapper (used by the extra)
        "debugpy", -- DAP
        "black", -- if you chose black
        -- "isort",     -- optional, ruff can replace it
        "pytest", -- for neotest-pytest runner helpers
      })
    end,
  },
}
