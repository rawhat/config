local wezterm = require("wezterm")

local colors = require("colors")
local domain = require("domain")
local fonts = require("fonts")
local graphics = require("graphics")
local keys = require("keys")
local style = require("style")

local config = wezterm.config_builder()

config.unicode_version = 15

colors.apply(config)
domain.apply(config)
fonts.apply(config)
graphics.apply(config)
keys.apply(config)
style.apply(config)

return config
