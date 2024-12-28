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

	-- Function to remove "notes" from args list
	local function pop_notes(local_args)
		for i, v in ipairs(local_args) do
			if v == "notes" then
				table.remove(local_args, i)
				return true
			end
		end
		return false
	end

	local project_dir = wezterm.home_dir
	local notes_dir = "/personal/notes"

	-- Check and remove "notes" from args
	local is_note_window = pop_notes(args)
	if is_note_window then
		project_dir = wezterm.home_dir .. notes_dir
		-- exit_behavior = "Close"
	end

	local _, build_pane, window = mux.spawn_window({
		workspace = "coding",
		cwd = project_dir,
		args = args,
	})

	window:gui_window():maximize()
	window:gui_window():focus()

	mux.set_active_workspace("coding")
end

return config
