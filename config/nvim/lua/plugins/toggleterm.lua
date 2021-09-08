local present, toggleterm = pcall(require, "toggleterm")

if not present then
	return
end

toggleterm.setup({
	size = 40,
	open_mapping = "<leader>`",
	insert_mappings = false,
	-- shade_terminals = false,
})

vim.api.nvim_exec(
	[[
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>
]],
	false
)
