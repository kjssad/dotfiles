local M = {}

local config = {
  virtual_text = false,
  float = {
    header = "",
    format = function(diagnostic)
      if diagnostic.code then
        return string.format("%s (%s) [%s]", diagnostic.message, diagnostic.source, diagnostic.code)
      end

      return string.format("%s (%s)", diagnostic.message, diagnostic.source)
    end,
    border = {
      { "🭽", "FloatBorder" },
      { "▔", "FloatBorder" },
      { "🭾", "FloatBorder" },
      { "▕", "FloatBorder" },
      { "🭿", "FloatBorder" },
      { "▁", "FloatBorder" },
      { "🭼", "FloatBorder" },
      { "▏", "FloatBorder" },
    },
    prefix = "",
    focusable = false,
  },
  update_in_insert = false,
  severity_sort = true,
}

function M.show_position_diagnostics()
  vim.diagnostic.open_float({ scope = "cursor" })
end

M.border = config.float.border

function M.setup()
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
