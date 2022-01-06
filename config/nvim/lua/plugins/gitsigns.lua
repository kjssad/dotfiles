local M = {}

local config = {
  signs = {
    add = { text = "▌" },
    change = { text = "▌" },
    delete = { text = "▶" },
    topdelete = { text = "▶" },
    changedelete = { text = "▌" },
  },
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 500,
  },
  status_formatter = function(status)
    local status_txt = (status.changed or status.removed) and "*" or ""
    status_txt = status.added and status_txt .. "+" or status_txt

    return status_txt
  end,
  preview_config = {
    border = require("plugins.lsp.diagnostic").border,
    row = 1,
  }
}

function M.setup()
  require("gitsigns").setup(config)
end

return M
