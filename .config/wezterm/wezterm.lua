local wezterm = require("wezterm")

local config = wezterm.config_builder()
local utils = require("utils")

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_background_opacity = 0.9
config.macos_window_background_blur = 30

config = utils.mergeTables(config, require("color"))
config = utils.mergeTables(config, require("tabbar"))
-- config = utils.mergeTables(config, require("keymaps"))
--

-- Auto applied config
-- require("smart-splits").run_smart_splits(config)
--
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')
smart_splits.apply_to_config(config, {
  -- the default config is here, if you'd like to use the default keys,
  -- you can omit this configuration table parameter and just use
  -- smart_splits.apply_to_config(config)

  -- directional keys to use in order of: left, down, up, right
  direction_keys = { 'h', 'j', 'k', 'l' },
  -- if you want to use separate direction keys for move vs. resize, you
  -- can also do this:
  direction_keys = {
    move = { 'h', 'j', 'k', 'l' },
    resize = { 'LeftArrow', 'DownArrow', 'UpArrow', 'RightArrow' },
  },
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = 'CTRL', -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = 'META', -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
})

return config
