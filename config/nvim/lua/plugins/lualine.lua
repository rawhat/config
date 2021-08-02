local present, lualine = pcall(require, "lualine")

if not (present) then
  return
end

local theme
if Global_theme == "tokyonight.nvim" then
  theme = 'tokyonight'
elseif Global_theme == "nord.nvim" then
  theme = 'nord'
elseif Global_theme == "neovim-ayu" then
  theme = 'ayu'
else
  error("Invalid theme in lualine config " .. Global_theme)
end

lualine.setup({
  options = {
    theme = theme,
  },
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
