local wezterm = require("wezterm")

local color = {}

local scheme = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
-- TODO: Use the theme color instead of hardcoding the value
scheme.split = "#cba6f7"

color.color_schemes = {
	["Catppuccin Mocha"] = scheme,
}

color.color_scheme = "Catppuccin Mocha"

return color
