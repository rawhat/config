local present, tokyonight = pcall(require, "tokyonight")

if present then
  vim.g.tokyonight_style = "night"
  vim.cmd[[colorscheme tokyonight]]

  return true
else
  return false
end

-- other ones i was using before

-- vim.cmd[[colorscheme nightfly]]

-- vim.g.ayu_mirage = true
-- vim.cmd[[colorscheme ayu]]

-- require('nord').set()

-- "default", "dark", "doom"
-- vim.g.neon_style = "dark"
-- vim.cmd[[colorscheme neon]]

-- require('github-theme').setup()
