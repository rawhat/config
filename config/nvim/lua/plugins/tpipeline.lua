local theme = require("themes").current_theme

return {
	--[[ "vimpostor/vim-tpipeline",
	cond = function()
		local is_linux = vim.fn.has("linux") == 1
		local is_osx = vim.fn.has("macunix") == 1
		local is_tmux = vim.fn.environ().TMUX ~= nil
		return (is_linux or is_osx) and is_tmux
	end,
	config = function()
		local colors = theme.heirline_colors(theme.palette)
		vim.g.tpipeline_clearstl = 1
		-- Unfortunately, these need to be different or else vim throws in `^^^` :(
		vim.api.nvim_set_hl(0, "StatusLine", { bg = colors.bg, fg = colors.bg2 })
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = colors.bg, fg = colors.fg1 })
		vim.cmd("set fcs=stlnc:─,stl:─,vert:│")
	end, ]]
}
