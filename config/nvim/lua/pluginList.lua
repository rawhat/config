local present, _ = pcall(require, "packerInit")
local packer

if present then
  packer = require("packer")
else
  return false
end

local use = packer.use

return packer.startup(
  function()
    -- manage packer
    use { 'wbthomason/packer.nvim' }

    -- deps
    use {
      'nvim-lua/plenary.nvim',
      event = "BufRead",
    }

    -- LANGUAGES
    -- cs
    use 'kchmck/vim-coffee-script'
    use 'mtscout6/vim-cjsx'
    ---- crystal
    use 'rhysd/vim-crystal'
    ---- csv
    use 'chrisbra/csv.vim'
    -- ---- fsharp
    use 'kongo2002/fsharp-vim'
    ---- git
    use 'tpope/vim-git'
    ---- gleam
    use 'gleam-lang/gleam.vim'
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
    use {
      'lewis6991/gitsigns.nvim',
      after = "plenary.nvim",
      event = "BufRead",
      config = function()
        require("plugins.gitsigns")
      end
    }

    -- modified status bar
    use {
      'hoob3rt/lualine.nvim',
      after = "tokyonight.nvim",
      config = function()
        require("plugins.lualine")
      end
    }

    -- line 'em up
    use 'godlygeek/tabular'

    -- fuzzy find
    use {
      'camspiers/snap',
      rocks = { 'fzy' },
      config = function()
        require("plugins.snap")
      end
    }

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
    use {
      'blackCauldron7/surround.nvim',
      config = function()
        require("plugins.surround")
      end
    }
    -- highlight/jump to characters in line
    use 'unblevable/quick-scope'
    -- fancy indent helper
    use{
      'lukas-reineke/indent-blankline.nvim',
      event = "BufRead",
      config = function()
        require("plugins.indent-blankline")
      end
    }
    -- highlights hex colors rgb(200, 200, 200)
    use 'norcalli/nvim-colorizer.lua'
    -- displays buffers at the top
    use {
      'ap/vim-buftabline',
      config = function()
        require("plugins.buftabline")
      end
    }
    -- `mix format`
    use 'mhinz/vim-mix-format'
    -- adjust color scheme
    use 'zefei/vim-colortuner'

    -- buffers
    use 'jeetsukumaran/vim-buffergator'

    -- some `lsp` configs
    use { 'kabouzeid/nvim-lspinstall' }
    use {
      'neovim/nvim-lspconfig',
      config = function()
        require("plugins.lspconfig")
      end
    }
    use {
      'hrsh7th/nvim-compe',
      event = "InsertEnter",
      config = function()
        require("plugins.compe")
      end
    }
    use {
      'scalameta/nvim-metals',
      config = function()
        require("plugins.metals")
      end
    }
    use {
      'folke/trouble.nvim',
      config = function()
        require 'trouble'.setup()
      end
    }

    -- file type icons
    use 'kyazdani42/nvim-web-devicons'

    -- file tree
    use {
      'kyazdani42/nvim-tree.lua',
      cmd = "NvimTreeToggle",
    }

    -- run things asynchronously
    use 'skywind3000/asyncrun.vim'

    -- neovim terminal manager
    use {
      'akinsho/nvim-toggleterm.lua',
      config = function()
        require("plugins.toggleterm")
      end
    }

    -- tree sitter
    use {
      'nvim-treesitter/nvim-treesitter',
      event = "BufRead",
      run = ':TSUpdate',
      config = function()
        require("plugins.treesitter")
      end
    }
    use {
      'nvim-treesitter/playground',
      event = "BufRead",
    }

    -- autocompletes html tags
    use {
      'windwp/nvim-ts-autotag',
      after = "nvim-treesitter",
      event = "BufRead",
      -- config = function()
      --   require('nvim-ts-autotag').setup()
      -- end
    }

    -- markdown preview
    use { 'npxbr/glow.nvim', run = ':GlowInstall' }

    -- display function signatures while typing
    use 'ray-x/lsp_signature.nvim'

    -- show pictograms on completion dropdown
    use {
      'onsails/lspkind-nvim',
      config = function()
        require 'lspkind'.init()
      end
    }

    -- which key???
    use {
      'folke/which-key.nvim',
      config = function()
        require 'which-key'.setup {}
      end
    }

    -- COLORSCHEMES
    use {
      'folke/tokyonight.nvim',
      config = function()
        require "theme"
      end
    }
    -- use 'Shatur95/neovim-ayu'
    -- use 'bluz71/vim-nightfly-guicolors'
    -- use 'shaunsingh/nord.nvim'
    -- use 'rafamadriz/neon'
    -- use 'projekt0n/github-nvim-theme'
  end
)
