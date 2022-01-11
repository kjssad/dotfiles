local M = {}
local loaded, null_ls = pcall(require, "null-ls")

local config = {
  diagnostic_format = "#{m} (#{s}) [#{c}]",
  on_attach = require("plugins.lsp").common_on_attach,
  sources = {
    null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.stylua,
  },
}

function M.setup()
  if loaded then
    null_ls.setup(config)
  end
end

return M
