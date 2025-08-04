local wezterm = require("wezterm")
local domain = require("domain")

local module = {}

-- @type { font: string | { family: string, weight?: string, italic?: boolean }, line_height?: number }
local font_configs = {
	{ font = "Rec Mono Linear", line_height = 1.1 },
	{ font = "Berkeley Mono" },
	{ font = "Iosevka JetBrains Mono" },
	{ font = "Iosevka Plex" },
	{ font = "Iosevka Wide" },
	{ font = { family = "Cascadia Code", weight = "DemiLight" }, line_height = 1.1 },
	{ font = "Hasklig" },
	{ font = "Ligalex Mono" },
	{ font = "JetBrains Mono" },
	{ font = "Fira Code" },
	{ font = { family = "CommitMono", weight = "Regular", italic = false } },
	{ font = "JuliaMono" },
	{ font = "SF Mono" },
	{ font = "Monaspace Argon" },
	{ font = "Monaspace Krypton" },
	{ font = "Monaspace Neon" },
	{ font = "Monaspace Radon" },
	{ font = "Monaspace Xenon" },
	{ font = "Liga Hack" },
	{ font = "Hack JBM Ligatured CCG" },
	{ font = { family = "IBM Plex Mono", weight = "Medium" } },
	{ font = { family = "Lilex", weight = "Regular" } },
	{ font = "League Mono" },
	{ font = "Liga SFMono Nerd Font" },
	{ font = "Rec Mono Custom" },
	{ font = "Hack" },
	{ font = "Monoid HalfLoose" },
	{ font = "VictorMono Nerd Font" },
	{ font = "Maple Mono" },
}

-- local current_font = "Rec Mono Linear"
-- local current_font = "Iosevka Wide"
module.current_font = "Berkeley Mono"

local font = {}

function module.apply(config)
	if domain.platform() == "macos" then
		config.font_size = 18.0
	else
		config.font_size = 14.0
	end
	for _, entry in pairs(font_configs) do
		if entry.font == module.current_font or entry.font.family == module.current_font then
			font = wezterm.font_with_fallback({ entry.font, "nonicons", "Symbols Nerd Font Mono" })
			for key, value in pairs(entry) do
				if key ~= "font" then
					font[key] = value
				end
			end
		end
	end
	config.font = font
end

return module
