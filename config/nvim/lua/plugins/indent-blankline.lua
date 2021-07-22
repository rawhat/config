local present, blankline = pcall(require, "indent_blankline")

if not present then
  error("Didn't have indent blankline...")
  return
end

vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankLine_char = "│"
-- vim.g["indent_blankline_space_char"] = "·"

vim.g.indent_guides_enable_on_vim_startup = 1
vim.g.indentLine_char_list = {'▏'}
