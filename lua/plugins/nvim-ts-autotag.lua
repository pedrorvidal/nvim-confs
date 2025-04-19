-- return {
--   {
--     "windwp/nvim-ts-autotag",
--     dependencies = "nvim-treesitter/nvim-treesitter",
--     event = "InsertEnter",
--     config = true, -- Use the default configuration instead of custom setup
--   },
-- }
return {
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "InsertEnter",
    opts = {
      enable = true,
      enable_rename = true,
      enable_close = true,
      enable_close_on_slash = true,
    },
  },
}
