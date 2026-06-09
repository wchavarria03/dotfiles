local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Quick terminal configuration optimized for notes
config.window_decorations = "RESIZE"
config.initial_rows = 100
config.initial_cols = 70
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

-- Clean interface for focused note-taking
config.enable_tab_bar = false
config.native_macos_fullscreen_mode = false

-- Lock the window title so aerospace can always identify this window,
-- regardless of what nvim or the shell sets.
wezterm.on("format-window-title", function()
	return "Quick Notes Terminal"
end)

-- Font optimization for readability
config.font_size = 14

return config

