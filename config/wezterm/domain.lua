local wezterm = require("wezterm")

local module = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	module.apply = require("domains.windows").apply
elseif wezterm.target_triple == "x86_64-apple-darwin" or wezterm.target_triple == "aarch64-apple-darwin" then
	module.apply = require("domains.macos").apply
else
	module.apply = require("domains.linux").apply
end

function module.platform()
	if wezterm.target_triple == "x86_64-pc-windows-msvc" then
		return "windows"
	elseif wezterm.target_triple == "x86_64-apple-darwin" or wezterm.target_triple == "aarch64-apple-darwin" then
		return "macos"
	else
		return "linux"
	end
end

return module
