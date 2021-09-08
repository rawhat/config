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
