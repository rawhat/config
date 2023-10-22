vim.api.nvim_create_autocmd({ "TermOpen" }, {
	callback = function()
		vim.cmd([[
       setlocal nonumber norelativenumber nocursorline winhl=Normal:NormalFloat
       tnoremap <buffer> <Esc> <c-\><c-n>
     ]])
	end,
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

-- TODO:  do i care about supporting a custom path?
vim.api.nvim_create_user_command("Decaffeinate", function(args)
	local cmd = vim.o.shell .. " -l bazel run @decaffeinate//:run -- " .. vim.fn.expand("%:p")
	require("terminal").run({
		"bazel",
		"run",
		"@decaffeinate//:run",
		"--",
		vim.fn.expand("%:p"),
	}, {
		layout = { open_cmd = "botright vertical new" },
	})
end, {})
