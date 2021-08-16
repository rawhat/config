local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

local packer = require('packer')

return packer.init({
  -- i... don't think i prefer this?
  --[[ display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end
  }, ]]
  git = {
    clone_timeout = 600,
  }
})
