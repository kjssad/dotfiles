local loaded, tmux = pcall(require, "tmux")

if not loaded then
  return
end

local M = {}

local config = {
  navigation = {
    cycle_navigation = false,
    enable_default_keybindings = true,
  },
}

function M.setup()
  tmux.setup(config)
end

return M
