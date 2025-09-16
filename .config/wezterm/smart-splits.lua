local wezterm = require("wezterm")

local module = {}

-- Helper function to check if we're at the edge and should switch to terminal
local function is_vim_process(pane)
	-- Check if the current pane is running vim/nvim
	local process_name = pane:get_foreground_process_name()
	return process_name and (
		process_name:find("n?vim") or 
		process_name:find("nvim") or 
		process_name:find("vim")
	)
end

function module.apply_to_config(config)
	local act = wezterm.action
	
	-- Smart splits implementation that works with Neovim
	local smart_splits_keys = {
		{
			key = "h",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				if is_vim_process(pane) then
					-- Send Ctrl+h to vim for vim navigation
					window:perform_action(act.SendKey({ key = "h", mods = "CTRL" }), pane)
				else
					-- Navigate WezTerm panes
					window:perform_action(act.ActivatePaneDirection("Left"), pane)
				end
			end),
		},
		{
			key = "j",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				if is_vim_process(pane) then
					window:perform_action(act.SendKey({ key = "j", mods = "CTRL" }), pane)
				else
					window:perform_action(act.ActivatePaneDirection("Down"), pane)
				end
			end),
		},
		{
			key = "k",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				if is_vim_process(pane) then
					window:perform_action(act.SendKey({ key = "k", mods = "CTRL" }), pane)
				else
					window:perform_action(act.ActivatePaneDirection("Up"), pane)
				end
			end),
		},
		{
			key = "l",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				if is_vim_process(pane) then
					window:perform_action(act.SendKey({ key = "l", mods = "CTRL" }), pane)
				else
					window:perform_action(act.ActivatePaneDirection("Right"), pane)
				end
			end),
		},
		
		-- Pane resizing (Alt + hjkl)
		{ key = "h", mods = "ALT", action = act.AdjustPaneSize({ "Left", 3 }) },
		{ key = "j", mods = "ALT", action = act.AdjustPaneSize({ "Down", 3 }) },
		{ key = "k", mods = "ALT", action = act.AdjustPaneSize({ "Up", 3 }) },
		{ key = "l", mods = "ALT", action = act.AdjustPaneSize({ "Right", 3 }) },
	}
	
	-- Ensure keys table exists
	config.keys = config.keys or {}
	
	-- Add smart splits keys to existing keys
	for _, key in ipairs(smart_splits_keys) do
		table.insert(config.keys, key)
	end
end

return module
