local vim = vim

local fn = vim.fn

vim.cmd('packadd packer.nvim')

local present, packer = pcall(require, "packer")

if not present then
  local packer_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

  vim.fn.delete(packer_path, "rf")
  vim.fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    "--depth",
    "20",
    packer_path
  })

  vim.cmd("packadd packer.nvim")
  present = pcall(require, "packer")

  if present then
    print("Packer cloned successfully")
  else
    error("Couldn't clone packer at path:  " .. packer_path)
  end
end

return packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end
  },
  git = {
    clone_timeout = 600,
  }
})
