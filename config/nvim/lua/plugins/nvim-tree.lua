local M = {}

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
}

function M.setup()
  local map = vim.keymap.set

  map("n", "<leader>k", "<cmd>NvimTreeFindFileToggle<CR>")
  map("n", "<leader>y", "<cmd>NvimTreeFindFile<CR>")

  vim.g.nvim_tree_indent_markers = 1

  require("nvim-tree").setup(config)
  require("nvim-tree.lib").toggle_ignored()
end

return M
