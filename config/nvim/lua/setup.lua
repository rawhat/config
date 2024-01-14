local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local utils = require("utils")
if not utils.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

local theme = require("themes").current_theme

require("lazy").setup("plugins", {
	install = {
		colorscheme = { theme.current_theme },
	},
	diff = {
		cmd = "terminal_git",
	},
	disabled_plugins = {
		"gzip",
		"matchit",
		"matchparen",
		"netrwPlugin",
		"tarPlugin",
		"tohtml",
		"tutor",
		"zipPlugin",
	},
})
