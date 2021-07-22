local present, lualine = pcall(require, "lualine")

if not (present) then
  return
end

lualine.setup({
  options = { theme = 'tokyonight' },
  extensions = { 'fzf', 'fugitive' },
  sections = {
    lualine_b = {
      { 'branch' },
      { 'diagnostics', sources = {'nvim_lsp'} },
    },
    lualine_c = {
      { 'filename', { path = 1 }},
    }
  },
})
