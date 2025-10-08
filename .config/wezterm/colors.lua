local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	local custom_scheme = {
		-- Background and foreground
		background = "#0b0b12",
		foreground = "#C1C9E6",

		-- Cursor colors
		cursor_bg = "#00BFFF",
		cursor_fg = "#C1C9E6",
		cursor_border = "#00BFFF",

		-- Selection colors
		selection_bg = "#464957",
		selection_fg = "#C1C9E6",

		-- Split divider color
		split = "#AD6FF7",

		-- Tab bar colors to blend with background
		tab_bar = {
			background = "#0b0b12",
			active_tab = {
				bg_color = "#0b0b12",
				fg_color = "#C1C9E6",
			},
			inactive_tab = {
				bg_color = "#191926",
				fg_color = "#A3AAC2",
			},
		},

		ansi = {
			"#191926", -- black (palette 0)
			"#E66767", -- red (palette 1)
			"#70CF67", -- green (palette 2)
			"#FACA64", -- yellow (palette 3)
			"#00BFFF", -- blue (palette 4)
			"#AD6FF7", -- magenta (palette 5)
			"#4CD4BD", -- cyan (palette 6)
			"#C1C9E6", -- white (palette 7)
		},
		brights = {
			"#464957", -- bright black (palette 8)
			"#F29D9D", -- bright red (palette 9)
			"#70CF67", -- bright green (palette 10)
			"#FAB770", -- bright yellow (palette 11)
			"#61BDFF", -- bright blue (palette 12)
			"#FF8F40", -- bright magenta (palette 13)
			"#00BBCC", -- bright cyan (palette 14)
			"#A3AAC2", -- bright white (palette 15)
		},
	}

	config.color_schemes = {
		["Custom Theme"] = custom_scheme,
	}
	config.color_scheme = "Custom Theme"
end

return module
