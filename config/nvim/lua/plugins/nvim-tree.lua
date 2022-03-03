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
    mappings = {
      list = {
        { key = "<C-e>", action = "" },
      },
    },
  },
}

local M = {}

function M.setup()
  vim.g.nvim_tree_indent_markers = 1

  nvim_tree.setup(config)
end

return M
