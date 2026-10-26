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

	local _, build_pane, window = mux.spawn_window({
		workspace = "coding",
		cwd = wezterm.home_dir,
		args = args,
	})

	window:gui_window():maximize()
	window:gui_window():focus()

	mux.set_active_workspace("coding")
end

return config
