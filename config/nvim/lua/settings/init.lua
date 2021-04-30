vim.g.encoding = "utf-8"

vim.wo.scrolloff = 3

vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

vim.g.wildmenu = true
vim.g.wildmode = "longest:full,full"

vim.g.termguicolors = true

vim.g.t_Co = "256"

vim.wo.number = true
vim.wo.relativenumber = true

vim.wo.colorcolumn = "81"

vim.o.clipboard = 'unnamedplus'

vim.cmd[[
  autocmd BufRead,BufNewFile *.bzl,WORKSPACE,BUILD.bazel setf bzl
  autocmd BufRead,BufNewFile BUILD setf bzl
]]

vim.cmd[[
  set completeopt-=preview
]]

-- These are set for CoC
vim.g.hidden = true
vim.g.nobackup = true
vim.g.nowritebackup = true

vim.g.updatetime = 300

-- ???
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.g.signcolumn = "yes"

vim.g.mapleader = ";"

vim.g.backupcopy = "yes"
