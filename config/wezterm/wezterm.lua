local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "QuantumDark"

config.font = wezterm.font({
  family = "JetBrains Mono",
  harfbuzz_features = { "cv06", "cv07", "ss19", "ss20", "zero" },
})
config.font_rules = {
  {
    italic = true,
    intensity = "Bold",
    font = wezterm.font("Victor Mono", { weight = "Medium", style = "Italic" }),
  },
}
config.font_size = 10
config.line_height = 1.2
config.underline_position = -4

config.enable_tab_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_close_confirmation = "NeverPrompt"

return config
