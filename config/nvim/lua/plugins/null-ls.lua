local M = {}
local null_ls = require("null-ls")

local config = {
  sources = {
    null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.stylua,
  },
}

function M.setup(options)
  null_ls.config(config)

  require("lspconfig")["null-ls"].setup(options)
end

return M

