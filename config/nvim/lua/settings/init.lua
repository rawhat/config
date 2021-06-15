vim.opt.encoding = "utf-8"

vim.opt.scrolloff = 3

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

vim.g.t_Co = "256"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.colorcolumn = "81"

vim.opt.clipboard = 'unnamedplus'

vim.cmd[[
  autocmd BufRead,BufNewFile *.bzl,WORKSPACE,BUILD.bazel setf bzl
  autocmd BufRead,BufNewFile BUILD setf bzl
]]

--[[
vim.cmd[[
  set completeopt-=preview
]]
--]]

vim.opt.completeopt = { "menuone", "noselect" }

-- for toggle term, reuse the same term
vim.opt.hidden = true

-- These are set for CoC
vim.g.hidden = true
vim.g.nobackup = true
vim.g.nowritebackup = true

vim.opt.updatetime = 300

vim.opt.shortmess = vim.opt.shortmess + 'c'

-- always show column to left of numbers for lsp/git symbols
vim.opt.signcolumn = "yes"

vim.g.mapleader = ";"

vim.g.backupcopy = "yes"

vim.opt.termguicolors = true

-- how dare you
vim.g.python_recommended_style = 0
