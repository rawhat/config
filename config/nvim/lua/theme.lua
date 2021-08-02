if Global_theme == "tokyonight.nvim" then
  vim.g.tokyonight_style = "night"
  vim.g.tokyonight_sidebars = { "which-key", "toggleterm", "packer.nvim" }
  vim.cmd[[colorscheme tokyonight]]
elseif Global_theme == "neovim-ayu" then
  vim.g.ayu_mirage = true
  vim.cmd[[colorscheme ayu]]
elseif Global_theme == "vim-nightfly-guicolors" then
  vim.cmd[[colorscheme nightfly]]
elseif Global_theme == "neon" then
  -- "default", "dark", "doom"
  vim.g.neon_style = "dark"
  vim.cmd[[colorscheme neon]]
elseif Global_theme == "github-nvim-theme" then
  require('github-theme').setup()
elseif Global_theme == 'nord.nvim' then
  vim.g.nord_contrast = true
  require('nord').set()
else
  error("Invalid theme " .. Global_theme .. " specified")
end
