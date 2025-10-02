local wezterm = require("wezterm")
local projects = require("projects")
local module = {}

function module.apply_to_config(config)
	config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

	config.keys = {
		{
			key = "Enter",
			mods = "SHIFT",
			action = wezterm.action({ SendString = "\x1b\r" }),
		},
		{
			key = "d",
			mods = "CMD|SHIFT",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "d",
			mods = "CMD",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "\\",
			mods = "LEADER",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "-",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "Enter",
			mods = "CMD|SHIFT",
			action = wezterm.action.TogglePaneZoomState,
		},
		-- Keep leader-based zoom as alternative
		{
			key = "m",
			mods = "LEADER",
			action = wezterm.action.TogglePaneZoomState,
		},
		{
			key = "p",
			mods = "LEADER",
			action = projects.choose_project(),
		},
		{
			key = "f",
			mods = "LEADER",
			action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
		},
	}
end

return module
