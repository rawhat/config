vim.cmd([[filetype plugin indent on]])

vim.cmd([[
  au BufRead,BufNewFile *.fish set filetype=fish
]])

vim.cmd([[
  autocmd BufNewFile,BufRead *.zig set ft=zig
  autocmd BufNewFile,BufRead *.zir set ft=zig
]])

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

function Inspect(obj)
	print(vim.inspect(obj))
end
