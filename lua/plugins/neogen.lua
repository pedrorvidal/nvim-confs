return {
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup({
        enabled = true,
        languages = {
          php = {
            template = {
              annotation_convention = "phpdoc", -- Use PHPDoc style
            },
          },
        },
      })
    end,
    keys = {
      {
        "<leader>pd",
        function()
          require("neogen").generate()
        end,
        desc = "Generate PHPDoc",
      },
    },
  },
}
