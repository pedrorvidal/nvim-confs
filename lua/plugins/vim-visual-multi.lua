-- return {
--   {
--     "mg979/vim-visual-multi",
--     branch = "master",
--   },
-- }
return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
    init = function()
      -- Default key mappings similar to VSCode
      vim.g.VM_maps = {
        ["Find Under"] = "<C-g>", -- Select word under cursor and go to next (like VSCode)
        ["Find Subword Under"] = "<C-g>", -- Select part of word under cursor
        ["Select All"] = "<C-A-g>", -- Select all occurrences
        ["Add Cursor Down"] = "<C-Down>", -- Add cursor down
        ["Add Cursor Up"] = "<C-Up>", -- Add cursor up
        ["Exit"] = "<Esc>", -- Exit multi-cursor mode
      }
    end,
  },
}
