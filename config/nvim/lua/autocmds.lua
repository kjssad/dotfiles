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
      utils.map("n", "q", ":q<CR>", { buffer = true })
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

  augroup("winbar_filetypes", {})
  autocmd({ "BufWinEnter", "BufFilePost" }, {
    group = "winbar_filetypes",
    callback = function()
      local filetype_exclude = { "help", "qf", "gitcommit", "fugitive", "NvimTree", "neo-tree-popup" }
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
  local highlight_augroup = augroup("lsp_document_highlight", { clear = false })
	vim.api.nvim_clear_autocmds({
		buffer = bufnr,
		group = highlight_augroup,
	})
  autocmd("CursorHold", {
    group = highlight_augroup,
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })
  autocmd("CursorMoved", {
    group = highlight_augroup,
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end

function M.lsp_codelens(bufnr)
  local lens_augroup = augroup("lsp_codelens", { clear = false })
	vim.api.nvim_clear_autocmds({
		buffer = bufnr,
		group = lens_augroup,
	})
  autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
    group = lens_augroup,
    buffer = bufnr,
    callback = vim.lsp.codelens.refresh,
  })
end

return M
