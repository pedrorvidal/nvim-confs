return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        commands = {
          -- Override default commands to add CD on open
          open = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" then
              -- Change directory when opening a directory
              vim.api.nvim_command("cd " .. node.path)
            end
            require("neo-tree.sources.filesystem.commands").open(state)
            if node.type == "file" then
              -- Change directory to the parent directory when opening a file
              local parent_path = vim.fn.fnamemodify(node.path, ":h")
              vim.api.nvim_command("cd " .. parent_path)
            end
          end,
        },
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer
        },
      },
      window = {
        mappings = {
          -- You might want to add a keymap for manually changing directory to current file
          ["c"] = {
            command = function()
              local node = require("neo-tree.sources.filesystem.commands").get_current_node()
              if node then
                if node.type == "directory" then
                  vim.api.nvim_command("cd " .. node.path)
                else
                  local parent_path = vim.fn.fnamemodify(node.path, ":h")
                  vim.api.nvim_command("cd " .. parent_path)
                end
                vim.notify("CD: " .. vim.fn.getcwd(), vim.log.levels.INFO)
              end
            end,
            desc = "Change working directory to current node",
          },
        },
      },
    },
  },
}
