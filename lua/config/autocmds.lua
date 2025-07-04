-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
-- This file is automatically loaded by lazyvim.config.init.

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
-- autochange dir when navigating thru folders and
-- fix initial dir when opens nvim

local augroup = vim.api.nvim_create_augroup("SetCwdOnBufEnter", { clear = true })

-- On VimEnter, set cwd if opening Neovim with a directory
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup,
  desc = "Set cwd to the opened directory when starting Neovim with `nvim .`",
  callback = function()
    local arg = vim.fn.argv(0)
    if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
      vim.cmd("cd " .. vim.fn.fnameescape(arg))
    end
  end,
})

-- On BufEnter, set cwd to the file's parent dir
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup,
  desc = "Change directory to current file's parent",
  callback = function(event)
    local bufname = vim.api.nvim_buf_get_name(event.buf)
    if bufname == "" or bufname:match("^neo%-tree") or vim.bo[event.buf].buftype ~= "" then
      return
    end
    local parent_dir = vim.fn.fnamemodify(bufname, ":h")
    if vim.fn.isdirectory(parent_dir) == 1 then
      vim.api.nvim_set_current_dir(parent_dir)
    end
  end,
})

-- This configuration ensures CWD changes when switching tabs/buffers
-- Add this to your lua/config/autocmds.lua file

-- local augroup = vim.api.nvim_create_augroup("AutoChdir", { clear = true })
--
-- -- Option 1: Change directory to the file's parent directory when opening a buffer
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   group = augroup,
--   desc = "Change directory to current file's parent",
--   callback = function(event)
--     -- Only process normal buffers with valid names
--     local bufname = vim.api.nvim_buf_get_name(event.buf)
--     if bufname == "" or bufname:match("^neo-tree") or vim.bo[event.buf].buftype ~= "" then
--       return
--     end
--
--     -- Change the directory to the parent directory of the current file
--     local parent_dir = vim.fn.fnamemodify(bufname, ":h")
--     vim.api.nvim_set_current_dir(parent_dir)
--   end,
-- })

-- Option 2: Change directory to the parent directory when switching tabs
-- Uncomment this if you want tab-specific directories
-- vim.api.nvim_create_autocmd({ "TabEnter" }, {
--   group = augroup,
--   desc = "Change directory to tab's file parent",
--   callback = function()
--     local bufnr = vim.api.nvim_get_current_buf()
--     local bufname = vim.api.nvim_buf_get_name(bufnr)
--     if bufname == "" or bufname:match("^neo-tree") or vim.bo[bufnr].buftype ~= "" then
--       return
--     end
--
--     local parent_dir = vim.fn.fnamemodify(bufname, ":h")
--     vim.api.nvim_set_current_dir(parent_dir)
--   end,
-- })

-- You can modify LazyVim's statusline to show current directory (optional)
-- Add this to your lua/plugins/lualine.lua file or create it if it doesn't exist
return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_c, {
        function()
          return "󱉭 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
        end,
      })
    end,
  },
}
