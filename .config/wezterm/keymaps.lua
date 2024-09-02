local wezterm = require("wezterm")
local keys = {}

keys.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

keys.keys = {
	{
		key = "'",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "5",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "m",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
}

return keys
