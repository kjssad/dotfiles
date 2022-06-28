local loaded, nvim_tree = pcall(require, "nvim-tree")

if not loaded then
  return
end

local config = {
  view = {
    width = 40,
    mappings = {
      list = {
        { key = "<C-e>", action = "" },
        { key = "<C-k>", action = "" },
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = "signcolumn",
      glyphs = {
        git = {
          unstaged = "M",
          staged = "S",
          unmerged = "U",
          renamed = "R",
          untracked = "?",
          deleted = "D",
        },
      },
    },
  },
  update_focused_file = {
    enable = true,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filesystem_watchers = {
    enable = true,
  },
}

local M = {}

function M.setup()
  nvim_tree.setup(config)
end

return M
