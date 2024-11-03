local function augroup(name, opts)
  vim.api.nvim_create_augroup(name, opts or { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd
local utils = require("utils")

local config_augroup = augroup("config_group")

-- Open help and quickfix windows at the verry bottom
autocmd("FileType", {
  group = config_augroup,
  pattern = { "help", "qf" },
  command = "wincmd J",
})

-- Close help and quickfix windows with `<q>`
autocmd("FileType", {
  group = config_augroup,
  pattern = { "help", "qf" },
  callback = function()
    utils.map("n", "q", ":q<CR>", { buffer = true })
  end,
})

-- Disable gutters and winbar in terminals
autocmd("TermOpen", {
  group = config_augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.winbar = nil
  end,
})

-- Show absolute numbers in Insert mode and when the buffer is unfocused, otherwise show relative numbers
local ln_augroup = augroup("line_numbers")
autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = ln_augroup,
  callback = function()
    utils.set_relative_number(true)
  end,
})
autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = ln_augroup,
  callback = function()
    utils.set_relative_number(false)
  end,
})

-- Save on focus lost
autocmd("FocusLost", {
  group = augroup("auto_save"),
  command = "silent! wa",
})

-- Open files at last cursor position
autocmd("BufReadPost", {
  group = augroup("last_cursor_pos"),
  callback = utils.last_cursor,
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ timeout = 250 })
  end,
})
