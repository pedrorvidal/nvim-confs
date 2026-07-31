-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- LazyVim already runs :checktime on FocusGained/TermClose/TermLeave, but
-- that never fires in tmux/multiplexer setups that don't forward focus
-- events. CursorHold (driven by updatetime) catches external edits (e.g.
-- from Claude Code) even when the Neovim pane never loses focus.
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("checktime_on_cursorhold", { clear = true }),
  command = "checktime",
})
