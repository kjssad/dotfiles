local M = {}

local config = {
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
  float = {
    header = "",
    format = function(diagnostic)
      local code = diagnostic.code
        or (diagnostic.user_data and diagnostic.user_data.lsp and diagnostic.user_data.lsp.code)

      if code then
        return string.format("%s %s (%s)", diagnostic.message, diagnostic.source, code)
      end

      return string.format("%s %s", diagnostic.message, diagnostic.source)
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
  jump = { float = true },
}

M.border = config.float.border

function M.setup()
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
