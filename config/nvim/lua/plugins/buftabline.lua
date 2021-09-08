local present = pcall(require, "butfabline")

if not present then
	return
end

vim.g.buftabline_numbers = 1
vim.g.buftabline_separators = 1
