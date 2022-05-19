local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local utils = require("utils")

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
      vim.opt_local.winbar = nil
    end,
  })
  autocmd("BufReadPost", {
    group = "config_group",
    callback = utils.last_cursor,
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
      utils.set_relative_number(true)
    end,
  })
  autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
    group = "line_numbers",
    callback = function()
      utils.set_relative_number(false)
    end,
  })

  augroup("packer_reload", {})
  autocmd("BufWritePost", {
    group = "packer_reload",
    pattern = "*/lua/plugins/init.lua",
    command = "source <afile> | PackerCompile",
  })

  augroup("winbar_filetypes", {})
  autocmd({ "BufWinEnter", "BufFilePost" }, {
    group = "winbar_filetypes",
    callback = function()
      local filetype_exclude = { "help", "qf", "gitcommit", "fugitive", "NvimTree" }
      local buftype_exclude = { "nofile" }

      if utils.in_table(filetype_exclude, vim.bo.filetype) or utils.in_table(buftype_exclude, vim.bo.buftype) then
        vim.opt_local.winbar = nil
        return
      end

      vim.opt_local.winbar = "%{%v:lua.require('utils').set_winbar()%}"
    end,
  })
end

function M.lsp_document_highlight(bufnr)
  augroup("lsp_document_highlight", {})
  autocmd("CursorHold", {
    group = "lsp_document_highlight",
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })
  autocmd("CursorMoved", {
    group = "lsp_document_highlight",
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end

function M.lsp_codelens(bufnr)
  augroup("lsp_codelens", {})
  autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
    group = "lsp_codelens",
    buffer = bufnr,
    callback = function()
      vim.lsp.codelens.refresh()
      vim.lsp.codelens.display()
    end,
  })
end

return M
