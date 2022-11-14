local languages = vim.api.nvim_create_augroup("Languages", { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "justfile", ".justfile", "*.just" },
	command = "set filetype=just",
	group = languages,
})

-- from https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1011938524
-- stop snippets when you leave to normal mode
local modes = vim.api.nvim_create_augroup("Helpers", { clear = true })
vim.api.nvim_create_autocmd({ "ModeChanged" }, {
	callback = function()
		if
			((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
			and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
			and not require("luasnip").session.jump_active
		then
			require("luasnip").unlink_current()
		end
	end,
	group = modes,
})
