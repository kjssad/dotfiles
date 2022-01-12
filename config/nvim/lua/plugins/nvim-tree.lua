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

function M.keymaps()
  local map = vim.keymap.set

  map("n", "<leader>k", "<cmd>NvimTreeFindFileToggle<CR>")
  map("n", "<leader>y", "<cmd>NvimTreeFindFile<CR>")
end

function M.setup()
  local loaded, nvim_tree = pcall(require, "nvim-tree")

  if loaded then
    vim.g.nvim_tree_indent_markers = 1

    nvim_tree.setup(config)
    require("nvim-tree.lib").toggle_ignored()
  end
end

return M
