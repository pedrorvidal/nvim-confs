return {
  "rest-nvim/rest.nvim",
  dependencies = {
    "rest-nvim/tree-sitter-http",
  },
  ft = "http", -- Optional: Load the plugin only for .http files
  config = function()
    -- Set global configuration options
    vim.g.rest_nvim = {
      -- Customize the result window
      result = {
        show_url = true,
        show_http_info = true,
        show_headers = true,
        show_statistics = true,
      },
      -- Add formatter configuration
      result_split_horizontal = false,
      formatter = {
        json = "jq",
        json_response = {
          error_on_line_overflow = false,
        },
      },
      -- Customize the environment (optional)
      env_file = ".env", -- Path to your environment file
      env_pattern = "\\.env$", -- Pattern to match environment files
      env_edit_command = "tabedit", -- Command to open the environment file
    }
  end,
}
