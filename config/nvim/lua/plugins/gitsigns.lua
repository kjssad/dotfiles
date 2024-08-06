return {
  "lewis6991/gitsigns.nvim",
  event = "BufRead",
  opts = {
    signs = {
      add = { text = "▌" },
      change = { text = "▌" },
      delete = { text = "▶" },
      topdelete = { text = "▶" },
      changedelete = { text = "▌" },
    },
    on_attach = require("keymaps").gitsigns,
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 500,
    },
    status_formatter = function(status)
      local added, changed, removed = status.added, status.changed, status.removed

      if (added and added > 0) or (removed and removed > 0) or (changed and changed > 0) then
        return "*"
      end

      return ""
    end,
    preview_config = {
      border = require("plugins.lsp.diagnostic").border,
      row = 1,
    },
  },
}
