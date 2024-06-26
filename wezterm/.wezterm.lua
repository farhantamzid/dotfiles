-- Pull in the wezterm API
local wezterm = require("wezterm")
local dimmer = { brightness = 0.10 }
-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Apple System Colors"
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold", italic = false })
config.font_size = 18
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}
config.window_background_opacity = 0.8
config.macos_window_background_blur = 60
config.enable_tab_bar = false
config.enable_scroll_bar = false
-- config.window_background_image = '/Users/farhantamzid/Downloads/pngegg.jpg'
-- config.window_background_image_hsb = {
-- Darken the background image by reducing it to 1/3rd
-- brightness = 0.05,

-- You can adjust the hue by scaling its value.
-- a multiplier of 1.0 leaves the value unchanged.
-- hue = 1.0,

-- You can adjust the saturatjjjon also.
-- saturation = 2.0,
-- }
-- config.background = {
--   {
--     source = {
--       Color = "black",
--     },
--   },
-- 	{
-- 		source = {
-- 			File = "/Users/farhantamzid/Downloads/pngegg.png",
-- 		},
-- 		opacity = 0.7,
--     horizontal_align = "Center",
--     vertical_align = "Middle",
--     height = "Contain",
--     width = "Contain",
--     -- height = "50%",
--     -- width = "50%",
--     repeat_x = "NoRepeat",
--     repeat_y = "NoRepeat"
-- 	},
-- }

-- and finally, return the configuration to wezterm
return config
