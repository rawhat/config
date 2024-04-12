local wezterm = require("wezterm")

local colors = require("colors")
local fonts = require("fonts")
local graphics = require("graphics")
local keys = require("keys")
local style = require("style")

local domains
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	domains = require("domains.windows")
elseif wezterm.target_triple == "x86_64-apple-darwin" or wezterm.target_triple == "aarch64-apple-darwin" then
	domains = require("domains.macos")
else
	domains = require("domains.linux")
end

local config = wezterm.config_builder()

config.unicode_version = 15

colors.apply(config)
domains.apply(config)
fonts.apply(config)
graphics.apply(config)
keys.apply(config)
style.apply(config)

return config
