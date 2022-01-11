local M = {}
local _, actions = pcall(require, "telescope.actions")
local _, action_set = pcall(require, "telescope.actions.set")

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
      },
    },
    sorting_strategy = "ascending",
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        preview_width = 80,
        prompt_position = "top",
      },
      vertical = {
        mirror = true,
        preview_cutoff = 30,
        prompt_position = "top",
      },
    },
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
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

function M.project_files()
  local loaded = pcall(require("telescope.builtin").git_files)

  if not loaded then
    require("telescope.builtin").find_files()
  end
end

function M.git_status()
  local loaded = pcall(require("telescope.builtin").git_status)

  if not loaded then
    vim.notify("telescope: working directory does not belong to a Git repository", 4)
  end
end

function M.setup()
  local loaded, telescope = pcall(require, "telescope")

  if loaded then
    local map = vim.keymap.set

    map("n", "<leader>t", require("plugins.telescope").project_files)
    map("n", "<leader>r", "<cmd>Telescope buffers<CR>")
    map("n", "<leader>e", "<cmd>Telescope find_files<CR>")
    map("n", "<leader>s", require("plugins.telescope").git_status)
    map("n", "<leader>rg", "<cmd>Telescope live_grep<CR>")

    telescope.setup(config)
    telescope.load_extension("fzf")
  end
end

return M
