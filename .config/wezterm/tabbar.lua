local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.use_fancy_tab_bar = false
	config.show_new_tab_button_in_tab_bar = false
	config.show_tab_index_in_tab_bar = true

	-- Equivalent to POSIX basename(3)
	-- Given "/foo/bar" returns "bar"
	-- Given "c:\\foo\\bar" returns "bar"
	local function basename(s)
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end

	local HALF_CIRCLE_LEFT = wezterm.nerdfonts.ple_left_half_circle_thick -- md_circle_half_full
	local HALF_CIRCLE_RIGHT = wezterm.nerdfonts.ple_right_half_circle_thick -- md_circle_half_full

	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		-- TODO: Get those values from the config theme, instead of hardcoding them
		local background = "#121212"
		local index_foreground = "#1C1B19"
		local index_background = "#94e2d5"
		local title_background = "#313244"
		local title_foreground = "#bac2de"

		if tab.is_active then
			index_background = "#cba6f7"
		end

		local process_name = tab.active_pane.foreground_process_name
		local exec_name = basename(process_name):gsub("%.exe$", "")

		local id = " " .. tostring(tab.tab_index + 1)

		local title = wezterm.truncate_right(exec_name, max_width - 6) .. "  "

		return {
			{ Background = { Color = background } },
			{ Text = " " },
			{ Attribute = { Intensity = "Bold" } },
			{ Background = { Color = background } },
			{ Foreground = { Color = title_background } },
			{ Text = HALF_CIRCLE_LEFT },
			{ Background = { Color = title_background } },
			{ Foreground = { Color = title_foreground } },
			{ Text = title },
			{ Background = { Color = index_background } },
			{ Foreground = { Color = index_foreground } },
			{ Text = id },
			{ Background = { Color = background } },
			{ Foreground = { Color = index_background } },
			{ Text = HALF_CIRCLE_RIGHT },
			{ Attribute = { Intensity = "Normal" } },
		}
	end)
end

return module
