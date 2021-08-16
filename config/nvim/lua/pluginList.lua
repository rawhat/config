local present, _ = pcall(require, "packerInit")
local packer

if present then
  packer = require("packer")
else
  return false
end

local use = packer.use

local themes = {
  tokyonight = {
    package = 'folke/tokyonight.nvim',
    package_name = 'tokyonight.nvim',
    name = 'tokyonight',
    config = function()
      vim.g.tokyonight_style = "night"
      vim.g.tokyonight_sidebars = { "which-key", "toggleterm", "packer.nvim" }
      vim.cmd[[colorscheme tokyonight]]
    end,
  },
  nord = {
    package = 'shaunsingh/nord.nvim',
    package_name = 'nord.nvim',
    name = 'nord',
    config = function()
      vim.g.nord_contrast = true
      require('nord').set()
    end,
  },
  ayu = {
    package = 'Shatur/neovim-ayu',
    package_name = 'neovim-ayu',
    name = 'ayu',
    config = function()
      vim.g.ayu_mirage = true
      vim.cmd[[colorscheme ayu]]
    end,
  },
  nightfly = {
    package = 'bluz71/vim-nightfly-guicolors',
    package_name = 'vim-nightfly-guicolors',
    name = 'nightfly',
    config = function()
    end,
  },
  neon = {
    package = 'rafamadriz/neon',
    package_name = 'neon',
    name = 'neon',
    config = function()
      -- "default", "dark", "doom"
      vim.g.neon_style = "dark"
      vim.cmd[[colorscheme neon]]
    end,
  },
  github = {
    package = 'projekt0n/github-nvim-theme',
    package_name = 'github-nvi-theme',
    name = 'github',
    config = function()
      require('github-theme').setup()
    end,
  }
}
Global_theme = themes['nord']

return packer.startup(
  function()

    -- COLORSCHEME
    use {
      Global_theme.package,
      after = "packer.nvim",
      config = function()
        Global_theme.config()
      end
    }

    -- manage packer
    use {
      'wbthomason/packer.nvim'
    }

    -- deps
    use {
      'nvim-lua/plenary.nvim',
      event = "BufRead",
    }

    -- LANGUAGES
    -- cs
    use {
      'kchmck/vim-coffee-script',
      ft = "coffee",
    }
    use {
      'mtscout6/vim-cjsx',
      ft = "coffee",
    }
    ---- crystal
    use {
      'rhysd/vim-crystal',
      ft = "crystal",
    }
    ---- csv
    use {
      'chrisbra/csv.vim',
      ft = "csv",
    }
    -- ---- fsharp
    use {
      'kongo2002/fsharp-vim',
      ft = "fsharp",
    }
    ---- git
    use {
      'tpope/vim-git',
      event = "BufEnter",
    }
    ---- gleam
    use {
      'gleam-lang/gleam.vim',
      ft = "gleam",
    }
    ---- jsonnet
    use {
      'google/vim-jsonnet',
      ft = "jsonnet",
    }
    ---- nginx
    use {
      'chr4/nginx.vim',
      ft = "nginx",
    }
    ---- nim
    use {
      'zah/nim.vim',
      ft = "nim",
    }
    ---- psql
    use {
      'lifepillar/pgsql.vim',
      ft = "sql",
    }
    ---- proto
    use {
      'uarun/vim-protobuf',
      ft = "protobuf",
    }
    ---- Pug
    use {
      'digitaltoad/vim-pug',
      ft = { "pug", "jade" }
    }
    ---- purescript
    use {
      'purescript-contrib/purescript-vim',
      ft = "purescript",
    }
    ---- reason
    use {
      'reasonml-editor/vim-reason-plus',
      ft = { "reason", "reasonreact" }
    }
    ---- sbt
    use {
      'derekwyatt/vim-sbt',
      ft = "sbt",
    }
    ---- xml
    use {
      'amadeus/vim-xml',
      ft = "xml",
    }

    -- # general
    -- emmet
    use {
      'mattn/emmet-vim',
      ft = { "html", "typescriptreact", "javascriptreact" }
    }
    -- * for visual selections
    use {
      'nelstrom/vim-visual-star-search',
      event = "BufEnter",
    }
    -- :noh on cursor move
    use {
      'haya14busa/is.vim',
      event = "BufEnter",
    }
    -- run tests
    use {
      'janko/vim-test',
      event = "BufEnter",
    }
    -- shell commands
    use {
      'tpope/vim-eunuch',
      event = "BufEnter",
    }

    -- OTHER

    -- displays symbols on site for add/delete/change
    use {
      'lewis6991/gitsigns.nvim',
      after = "plenary.nvim",
      config = function()
        require("plugins.gitsigns")
      end
    }

    -- modified status bar
    use {
      'hoob3rt/lualine.nvim',
      after = Global_theme.package_name,
      config = function()
        require("plugins.lualine")
      end
    }

    -- fuzzy find
    use {
      'camspiers/snap',
      -- rocks = { 'fzy' },
      config = function()
        require("plugins.snap")
      end
    }

    -- search!
    use {
      'mileszs/ack.vim',
      event = "BufEnter",
    }
    -- highlights trailing whitespace
    use {
      'ntpeters/vim-better-whitespace',
      event = "BufEnter",
    }
    -- auto-add matching symbols (, --, etc
    use {
      'raimondi/delimitmate',
      event = "BufEnter",
    }
    -- ez commenting
    use {
      'b3nj5m1n/kommentary',
      event = "BufEnter",
    }
    -- git good
    use {
      'tpope/vim-fugitive',
      event = "BufEnter",
    }
    -- (--'happy times'--)
    use {
      'blackCauldron7/surround.nvim',
      event = "BufEnter",
      config = function()
        require("plugins.surround")
      end
    }
    -- highlight/jump to characters in line
    use {
      'unblevable/quick-scope',
      event = "BufEnter",
    }
    -- fancy indent helper
    use{
      'lukas-reineke/indent-blankline.nvim',
      event = "BufRead",
      config = function()
        require("plugins.indent-blankline")
      end
    }
    -- highlights hex colors rgb(200, 200, 200)
    use {
      'norcalli/nvim-colorizer.lua',
      event = "BufEnter",
    }
    -- displays buffers at the top
    use {
      'ap/vim-buftabline',
      event = "VimEnter",
      config = function()
        require("plugins.buftabline")
      end
    }
    -- `mix format`
    use {
      'mhinz/vim-mix-format',
      ft = "elixir",
    }
    -- buffers
    use {
      'jeetsukumaran/vim-buffergator',
      event = "VimEnter",
    }

    -- some `lsp` configs
    use {
      'kabouzeid/nvim-lspinstall',
    }
    use {
      'neovim/nvim-lspconfig',
      config = function()
        require("plugins.lspconfig")
      end,
    }

    use {
      'ms-jpq/coq_nvim',
      before = 'nvim-lspconfig',
      branch = 'coq',
      config = function()
        require('plugins.coq')
      end,
    }

    use {
      'ms-jpq/coq.artifacts',
      before = 'nvim-lspconfig',
      branch = 'artifacts'
    }

    use {
      'scalameta/nvim-metals',
      ft = "scala",
      config = function()
        require("plugins.metals")
      end
    }
    use {
      'folke/trouble.nvim',
      after = Global_theme.package_name,
      config = function()
        require 'trouble'.setup()
      end
    }

    -- file type icons
    use {
      'kyazdani42/nvim-web-devicons',
      event = "VimEnter",
    }

    -- file tree
    use {
      'kyazdani42/nvim-tree.lua',
      cmd = "NvimTreeToggle",
    }

    -- run things asynchronously
    use {
      'skywind3000/asyncrun.vim',
      event = "BufEnter",
    }

    -- neovim terminal manager
    use {
      'akinsho/nvim-toggleterm.lua',
      after = Global_theme.package_name,
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
      -- event = "BufRead",
      after = "nvim-treesitter",
      config = function()
        require('nvim-ts-autotag').setup()
      end
    }

    -- markdown preview
    use {
      'npxbr/glow.nvim',
      run = ':GlowInstall',
      ft = "markdown",
    }

    -- display function signatures while typing
    use {
      'ray-x/lsp_signature.nvim',
      event = "BufEnter",
    }

    -- show pictograms on completion dropdown
    use {
      'onsails/lspkind-nvim',
      event = "InsertEnter",
      config = function()
        require 'lspkind'.init()
      end
    }

    -- which key???
    use {
      'folke/which-key.nvim',
      after = Global_theme.package_name,
      config = function()
        require 'which-key'.setup {}
      end
    }
  end
)
