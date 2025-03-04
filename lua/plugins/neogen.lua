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
              annotation_convention = "phpdoc",
              -- Add PSR-specific configurations
              use_package_namespace = true, -- Include namespace in doc blocks
              param_type_first = true, -- Format as @param type $name
              include_param_description = true,
              include_return_type = true,
              include_func_description = true,
              include_throw_description = true,
              include_class_description = true,
            },
          },
        },
        -- Remove snippet engine specification
        enable_placeholders = true, -- Add placeholders for descriptions
        placeholders_text = {
          description = "Description",
          param_description = "Parameter description",
          return_description = "Return value description",
          throw_description = "Exception description",
        },
      })
    end,
    keys = {
      {
        "<leader>pd",
        function()
          require("neogen").generate({ type = "func" })
        end,
        desc = "Generate Function PHPDoc",
      },
      {
        "<leader>pc",
        function()
          require("neogen").generate({ type = "class" })
        end,
        desc = "Generate Class PHPDoc",
      },
    },
  },
}
