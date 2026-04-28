local wezterm = require("wezterm")
local domain = require("domain")

local module = {}

-- @type { font: string | { family: string, weight?: string, italic?: boolean }, line_height?: number }
local font_configs = {
	-- { font = "Rec Mono Linear", line_height = 1.1 },
	{ font = "Fira Code" },
	{ font = "Hack JBM Ligatured CCG" },
	{ font = "Hack" },
	{ font = "Hasklig" },
	{ font = "Iosevka Input" },
	{ font = "Iosevka JetBrains Mono" },
	{ font = "Iosevka JetBrains" },
	{ font = "Iosevka Plex" },
	{ font = "Iosevka Recursive" },
	{ font = "Iosevka SourceCode" },
	{ font = "Iosevka Wide" },
	{ font = "Ioskeley Mono" },
	{ font = "JetBrains Mono" },
	{ font = "JuliaMono" },
	{ font = "League Mono" },
	{ font = "Liga Hack" },
	{ font = "Liga SFMono Nerd Font" },
	{ font = "Ligalex Mono" },
	{ font = "Maple Mono" },
	{ font = "Monaspace Argon" },
	{ font = "Monaspace Krypton" },
	{ font = "Monaspace Neon" },
	{ font = "Monaspace Radon" },
	{ font = "Monaspace Xenon" },
	{ font = "Monoid HalfLoose" },
	{ font = "Rec Mono Custom" },
	{ font = "Rec Mono Linear" },
	{ font = "SF Mono" },
	{ font = "VictorMono Nerd Font" },
	{ font = { family = "Berkeley Mono" } },
	{ font = { family = "Cascadia Code", weight = "DemiLight" }, line_height = 1.1 },
	{ font = { family = "CommitMono", weight = "Regular", italic = false } },
	{ font = { family = "IBM Plex Mono", weight = "Medium" } },
	{ font = { family = "Lilex", weight = "Regular" } },
}

-- module.current_font = "Iosevka Wide"
-- module.current_font = "Berkeley Mono"
-- module.current_font = "Rec Mono Linear"
-- module.current_font = "Iosevka Input"
-- module.current_font = "Iosevka JetBrains"
-- module.current_font = "Iosevka Plex"
-- module.current_font = "Iosevka Recursive"
module.current_font = "Ioskeley Mono"
-- module.current_font = "Lilex"
-- module.current_font = "Iosevka SourceCode"

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
