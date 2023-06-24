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

-- TODO:  needed?
vim.cmd([[
  au BufRead,BufNewFile *.fish set filetype=fish
]])

-- TODO:  needed?
vim.cmd([[
  autocmd BufNewFile,BufRead *.zig set ft=zig
  autocmd BufNewFile,BufRead *.zir set ft=zig
]])

-- TODO:  needed?
vim.cmd([[
  autocmd BufNewFile,BufRead *.ex set ft=elixir
  autocmd BufNewFile,BufRead *.exs set ft=elixir
]])

vim.cmd([[
  com! CheckHighlightUnderCursor echo {l,c,n ->
          \   'hi<'    . synIDattr(synID(l, c, 1), n)             . '> '
          \  .'trans<' . synIDattr(synID(l, c, 0), n)             . '> '
          \  .'lo<'    . synIDattr(synIDtrans(synID(l, c, 1)), n) . '> '
          \ }(line("."), col("."), "name")
]])
