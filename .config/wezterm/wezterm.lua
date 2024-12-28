local wezterm = require("wezterm")
local colors = require("colors")
local tabbar = require("tabbar")
local keys = require("keys")
local editor = require("editor")
local smart_splits = require("smart-splits")
local bootstrap = require("bootstrap")

local config = wezterm.config_builder()

editor.apply_to_config(config)
colors.apply_to_config(config)
tabbar.apply_to_config(config)
keys.apply_to_config(config)
smart_splits.apply_to_config(config)

wezterm.on("gui-startup", bootstrap.init)

return config
