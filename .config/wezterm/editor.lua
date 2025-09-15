local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.font = wezterm.font("JetBrains Mono NL", { weight = "Regular" })
	config.font_size = 14

	config.window_padding = { left = 10, right = 10, top = 10, bottom = 10 }
	
	-- Window styling only (tabs handled in tabbar.lua)
	config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
	
	config.quit_when_all_windows_are_closed = true
	
	config.window_background_opacity = 0.9
	config.macos_window_background_blur = 25
	config.text_background_opacity = 1.0
end

return module
