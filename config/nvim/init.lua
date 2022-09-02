require("pluginList")
require("options")
require("utils")
require("cmds")

if vim.g.neovide ~= nil then
	vim.g.neovide_refresh_rate = 144
	vim.g.neovide_cursor_animation_length = 0
	vim.opt.guifont = {
		-- "Iosevka JetBrains Mono", ":h13",
		"Cascadia Code SemiLight",
		":h13",
		"nonicons",
		":h13",
		"SauceCodePro NF",
		":h13",
	}
end
