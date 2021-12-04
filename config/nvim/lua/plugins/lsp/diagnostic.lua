local M = {}

-- local border = {
--   { "▁", "FloatBorder" },
--   { "▁", "FloatBorder" },
--   { "▁", "FloatBorder" },
--   { "▕", "FloatBorder" },
--   { "▔", "FloatBorder" },
--   { "▔", "FloatBorder" },
--   { "▔", "FloatBorder" },
--   { "▏", "FloatBorder" },
-- -- }

-- local border = "single"

local function diagnostic_format(diagnostic)
  return string.format("%s (%s)", diagnostic.message, diagnostic.source)
end

function M.show_position_diagnostics()
  vim.diagnostic.open_float(0, { scope = "cursor" })
end

M.border = {
  { "🭽", "FloatBorder" },
  { "▔", "FloatBorder" },
  { "🭾", "FloatBorder" },
  { "▕", "FloatBorder" },
  { "🭿", "FloatBorder" },
  { "▁", "FloatBorder" },
  { "🭼", "FloatBorder" },
  { "▏", "FloatBorder" },
}

function M.setup()
  local config = {
    virtual_text = false,
    float = {
      header = "",
      format = diagnostic_format,
      border = M.border,
      prefix = "",
      focusable = false,
    },
    update_in_insert = false,
    severity_sort = true,
  }

  local signs = { Error = "", Warn = "", Info = "", Hint = "" }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl })
  end

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = M.border,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = M.border,
  })

  -- vim.cmd([[autocmd CursorHold,CursorHoldI * lua require('plugins.lsp').show_line_diagnostics()]])
  -- vim.cmd([[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]])
  -- vim.cmd([[autocmd CursorHold * lua require("plugins.lsp.diagnostic").show_position_diagnostics()]])
end

return M
