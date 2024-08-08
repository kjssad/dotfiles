local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "QuantumDark"

config.font_size = 10
config.line_height = 1.2

config.enable_tab_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_close_confirmation = "NeverPrompt"

return config
