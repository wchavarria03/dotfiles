local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.font = wezterm.font("JetBrains Mono", { weight = "Regular", stretch = "Normal", style = "Normal" })
	config.font_size = 14

	config.window_padding = { left = 20, right = 20, top = 20, bottom = 10 }

	config.window_decorations = "RESIZE"

	config.quit_when_all_windows_are_closed = true

	config.window_background_opacity = 0.9
	config.macos_window_background_blur = 25
end

return module
