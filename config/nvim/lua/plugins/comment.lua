local loaded, comment = pcall(require, "Comment")

if not loaded then
  return
end

local M = {}

local config = {
  ignore = "^$",
}

function M.setup()
  comment.setup(config)
end

return M
