local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	local scheme = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
	-- TODO: Use the theme color instead of hardcoding the value
	scheme.split = "#cba6f7"

	config.color_schemes = {
		["Catppuccin Mocha"] = scheme,
	}
	config.color_scheme = "Catppuccin Mocha"
end

return module
