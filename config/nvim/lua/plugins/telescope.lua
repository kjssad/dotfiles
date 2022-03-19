local loaded, telescope = pcall(require, "telescope")

if not loaded then
  return
end

local actions = require("telescope.actions")
local action_set = require("telescope.actions.set")
local action_layout = require("telescope.actions.layout")

-- workaround to fix folds
-- https://github.com/nvim-telescope/telescope.nvim/issues/559#issuecomment-934727312
local fixfolds = {
  hidden = true,
  attach_mappings = function(_)
    action_set.select:enhance({
      post = function()
        vim.cmd(":normal! zx")
      end,
    })
    return true
  end,
}

local config = {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-space>"] = action_layout.toggle_preview,
      },
    },
    sorting_strategy = "ascending",
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        preview_width = 90,
        prompt_position = "top",
      },
      vertical = {
        mirror = true,
        preview_cutoff = 30,
        prompt_position = "top",
      },
    },
    borderchars = {
      { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
      prompt = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
      results = { " ", "▕", "▁", "▏", "▏", "▕", "🭿", "🭼" },
    },
    vim_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim",
    },
  },
  pickers = {
    buffers = fixfolds,
    file_browser = fixfolds,
    find_files = fixfolds,
    git_files = fixfolds,
    grep_string = fixfolds,
    live_grep = fixfolds,
    oldfiles = fixfolds,
  },
}

local M = {}

function M.project_files()
  local in_git_repo = pcall(require("telescope.builtin").git_files)

  if not in_git_repo then
    require("telescope.builtin").find_files()
  end
end

function M.git_status()
  require("telescope.builtin").git_status({
    git_icons = {
      added = "A",
      changed = "M",
      copied = "C",
      deleted = "D",
      renamed = "R",
      unmerged = "U",
      untracked = "?",
    },
  })
end

function M.setup()
  telescope.setup(config)
  telescope.load_extension("fzf")
end

return M
