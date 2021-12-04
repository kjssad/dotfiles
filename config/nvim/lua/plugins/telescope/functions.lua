local themes = require("plugins.telescope.themes")
local builtin = require("telescope.builtin")
local Job = require("plenary.job")
local M = {}

function M.project_files(opts)
  -- local opts = opts or {}
  -- local opts_with_themes = themes.flex(opts)
  local opts_with_themes = opts

  local cwd = vim.loop.cwd()
  local stderr = {}
  local _, ret = Job
    :new({
      command = "git",
      args = { "rev-parse", "--show-toplevel" },
      cwd = cwd,
      on_stderr = function(_, data)
        table.insert(stderr, data)
      end,
    })
    :sync()

  if ret ~= 0 then
    builtin.find_files(opts_with_themes)
  else
    builtin.git_files(opts_with_themes)
  end
end

return M
