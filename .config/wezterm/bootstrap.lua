local wezterm = require("wezterm")
local mux = wezterm.mux
local config = {}

config.init = function(cmd)
	-- allow `wezterm start -- something` to affect what we spawn
	-- in our initial window
	local args = {}
	if cmd then
		args = cmd.args
	end

	-- Set a workspace for coding on a current project
	-- Top pane is for the editor, bottom pane is for the build tool
	local project_dir = wezterm.home_dir
	local _, build_pane, window = mux.spawn_window({
		workspace = "coding",
		cwd = project_dir,
		args = args,
	})

	build_pane:split({
		direction = "Top",
		size = 0.8,
		cwd = project_dir,
	})

	window:gui_window():maximize()

	-- We want to startup in the coding workspace
	mux.set_active_workspace("coding")
end

return config
