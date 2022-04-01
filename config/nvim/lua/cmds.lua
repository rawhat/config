local languages = vim.api.nvim_create_augroup("Languages", { clear = true })
local base = vim.api.nvim_create_augroup("BaseCommands", { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "justfile", ".justfile", "*.just" },
	command = "setfiletype just",
})

vim.api.nvim_create_autocmd("VimLeave", {
	-- `modes.nvim` modifies the cursor, and it seems like maybe `wezterm` doesn't
	-- play well with that?  so this is needed to reset to block, which is what i
	-- normally use... hopefully that is okay
	callback = function()
		vim.cmd([[set guicursor=a:block-Cursor]])
	end,
	group = base,
})
