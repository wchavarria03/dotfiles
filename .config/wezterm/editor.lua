local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.font = wezterm.font("JetBrainsMono Nerd Font")
	config.font_size = 14

	config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
	config.window_background_opacity = 0.9
	config.macos_window_background_blur = 30
end

return module
