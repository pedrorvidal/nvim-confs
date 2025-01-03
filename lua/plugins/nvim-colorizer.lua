return {
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*", -- Enable colorizer for all file types
      }, {
        names = false, -- Disable color names like Blue or Red
      })
    end,
  },
}
