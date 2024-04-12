local wezterm = require("wezterm")

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
}

local current_font = "Rec Mono Linear"

function module.apply(config)
	config.font_size = 14.0
	for _, entry in pairs(font_configs) do
		if entry.font == current_font or entry.font.family == current_font then
			config.font = wezterm.font_with_fallback({ entry.font, "nonicons", "SauceCodePro NF" })
			for key, value in pairs(entry) do
				if key ~= "font" then
					config[key] = value
				end
			end
		end
	end
end

return module
