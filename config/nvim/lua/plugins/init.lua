local vim = vim

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')

require('packer').startup(function(use)

  -- manage packer
  use { 'wbthomason/packer.nvim', opt = true }

  -- LANGUAGES
  -- cs
  use 'kchmck/vim-coffee-script'
  use 'mtscout6/vim-cjsx'
  ---- crystal
  use 'rhysd/vim-crystal'
  ---- csv
  use 'chrisbra/csv.vim'
  ---- dockerfile
  use 'ekalinin/Dockerfile.vim'
  ---- elixir
  -- use 'elixir-editors/vim-elixir'
  ---- fish
  use 'georgewitteman/vim-fish'
  ---- fsharp
  use 'kongo2002/fsharp-vim'
  ---- git
  use 'tpope/vim-git'
  ---- gleam
  use 'gleam-lang/gleam.vim'
  ---- go
  use 'ray-x/go.nvim'
  ---- jsonnet
  use 'google/vim-jsonnet'
  ---- nginx
  use 'chr4/nginx.vim'
  ---- nim
  use 'zah/nim.vim'
  ---- psql
  use 'lifepillar/pgsql.vim'
  ---- proto
  use 'uarun/vim-protobuf'
  ---- Pug
  use 'digitaltoad/vim-pug'
  ---- purescript
  use 'purescript-contrib/purescript-vim'
  ---- reason
  use 'reasonml-editor/vim-reason-plus'
  ---- sbt
  use 'derekwyatt/vim-sbt'
  ---- scss
  use 'cakebaker/scss-syntax.vim'
  ---- xml
  use 'amadeus/vim-xml'

  -- # general
  -- emmet
  use 'mattn/emmet-vim'
  -- * for visual selections
  use 'nelstrom/vim-visual-star-search'
  -- :noh on cursor move
  use 'haya14busa/is.vim'
  -- run tests
  use 'janko/vim-test'
  -- shell commands
  use 'tpope/vim-eunuch'

  -- OTHER
  -- displays symbols on site for add/delete/change
  use 'airblade/vim-gitgutter'
  -- modified status bar
  use 'hoob3rt/lualine.nvim'
  -- line 'em up
  use 'godlygeek/tabular'
  -- fuzzy find
  -- use  { 'junegunn/fzf', run = "fzf#install()" }
  -- use 'junegunn/fzf.vim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- search!
  use 'mileszs/ack.vim'
  -- highlights trailing whitespace
  use 'ntpeters/vim-better-whitespace'
  -- auto-add matching symbols (, --, etc
  use 'raimondi/delimitmate'
  -- ez commenting
  use 'b3nj5m1n/kommentary'
  -- git good
  use 'tpope/vim-fugitive'
  -- (--'happy times'--)
  use 'blackCauldron7/surround.nvim'
  -- highlight/jump to characters in line
  use 'unblevable/quick-scope'
  -- fancy indent helper
  use { 'lukas-reineke/indent-blankline.nvim', branch = 'lua' }
  -- highlights hex colors rgb(200, 200, 200)
  use 'norcalli/nvim-colorizer.lua'
  -- displays buffers at the top
  use 'ap/vim-buftabline'
  -- `mix format`
  use 'mhinz/vim-mix-format'
  -- adjust color scheme
  use 'zefei/vim-colortuner'

  -- buffers
  use 'jeetsukumaran/vim-buffergator'

  -- some `lsp` configs
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'scalameta/nvim-metals'
  use 'alexaandru/nvim-lspupdate'
  use 'folke/trouble.nvim'

  -- file type icons
  use 'kyazdani42/nvim-web-devicons'

  -- file tree
  use 'kyazdani42/nvim-tree.lua'

  -- run things asynchronously
  use 'skywind3000/asyncrun.vim'

  -- neovim terminal manager
  use 'akinsho/nvim-toggleterm.lua'

  -- tree sitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-treesitter/playground'

  -- autocompletes html tags
  use 'windwp/nvim-ts-autotag'

  -- markdown preview
  use { 'npxbr/glow.nvim', run = ':GlowInstall' }

  -- display function signatures while typing
  -- use 'ray-x/lsp_signature.nvim'

  -- show pictograms on completion dropdown
  use 'onsails/lspkind-nvim'

  -- COLORSCHEMES
  use 'folke/tokyonight.nvim'

end)
