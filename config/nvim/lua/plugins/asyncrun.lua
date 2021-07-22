local present = pcall(require, "asyncrun")

if not present then
  return
end

vim.g.asyncrun_open = 10
vim.g.asyncrun_local = 1

vim.cmd[[cnoreabbrev ar AsyncRun]]
