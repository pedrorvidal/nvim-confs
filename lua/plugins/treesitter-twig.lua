return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Add twig to the ensure_installed table
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "twig" })
      end
    end,
  },
}
