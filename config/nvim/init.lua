-- for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("options")
require("pluginList")
require("cmds")
require("keymaps")

if vim.g.neovide then
	vim.g.neovide_refresh_rate = 144
	vim.g.neovide_cursor_animation_length = 0
	vim.o.guifont = "Iosevka JetBrains Mono,nonicons,SauceCodePro NF:h12"
end

if vim.g.fvim_loaded then
	vim.defer_fn(function()
		vim.cmd.FVimFontAntialias(true)
		vim.cmd.FVimFontLigature(true)
		vim.cmd.FVimFontSubpixel(true)
	end, 50)
	vim.o.guifont = "Iosevka JetBrains Mono,nonicons,SauceCodePro NF:h13"
end
