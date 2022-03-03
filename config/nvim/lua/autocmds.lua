local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local M = {}

function M.defaults()
  augroup("config_group", {})
  autocmd("FocusLost", {
    group = "config_group",
    command = "silent! wa",
  })
  autocmd("FileType", {
    group = "config_group",
    pattern = { "help", "qf" },
    command = "wincmd J",
  })
  autocmd("FileType", {
    group = "config_group",
    pattern = { "help", "qf" },
    callback = function()
      vim.keymap.set("n", "q", ":q<CR>", { buffer = true })
    end,
  })
  autocmd("TermOpen", {
    group = "config_group",
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn = "no"
    end,
  })
  autocmd("BufReadPost", {
    group = "config_group",
    callback = require("utils").last_cursor,
  })
  autocmd("TextYankPost", {
    group = "config_group",
    callback = function()
      vim.highlight.on_yank({ timeout = 250 })
    end,
  })

  augroup("line_numbers", {})
  autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
    group = "line_numbers",
    callback = function()
      require("utils").set_relative_number(true)
    end,
  })
  autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
    group = "line_numbers",
    callback = function()
      require("utils").set_relative_number(false)
    end,
  })

  augroup("packer_reload", {})
  autocmd("BufWritePost", {
    group = "packer_reload",
    command = "source <afile> | PackerCompile",
  })
end

function M.lsp_document_highlight()
  augroup("lsp_document_highlight", {})
  autocmd("CursorHold", {
    group = "lsp_document_highlight",
    pattern = "<buffer>",
    callback = vim.lsp.buf.document_highlight,
  })
  autocmd("CursorMoved", {
    group = "lsp_document_highlight",
    pattern = "<buffer>",
    callback = vim.lsp.buf.clear_references,
  })
end

function M.lsp_codelens()
  augroup("lsp_codelens", {})
  autocmd("InsertLeave", {
    group = "lsp_codelens",
    pattern = "<buffer>",
    callback = function()
      vim.lsp.codelens.refresh()
      vim.lsp.codelens.display()
    end,
  })
end

return M
