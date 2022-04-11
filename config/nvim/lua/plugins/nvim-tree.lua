local loaded, nvim_tree = pcall(require, "nvim-tree")

if not loaded then
  return
end

local config = {
  diagnostics = {
    enable = true,
    icons = {
      error = "",
      warn = "",
      info = "",
      hint = "",
    },
  },
  update_focused_file = {
    enable = true,
  },
  view = {
    width = 40,
    mappings = {
      list = {
        { key = "<C-e>", action = "" },
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
}

local M = {}

function M.setup()
  vim.g.nvim_tree_icons = {
    git = {
      unstaged = "M",
      staged = "S",
      unmerged = "U",
      renamed = "R",
      untracked = "?",
      deleted = "D",
    },
  }

  nvim_tree.setup(config)
end

return M
