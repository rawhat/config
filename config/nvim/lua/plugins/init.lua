local vim = vim

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')

require('packer').startup(function(use)

    -- manage packer
    use {'wbthomason/packer.nvim', opt = true}

    -- deps
    use 'nvim-lua/plenary.nvim'

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
        config = function()
            require('gitsigns').setup({use_internal_diff = false})
        end
    }

    -- modified status bar
    use {
        'hoob3rt/lualine.nvim',
        config = function()
            require('lualine').setup {
                options = {theme = 'tokyonight'},
                -- options = { theme = 'github' },
                extensions = {'fzf', 'fugitive'},
                sections = {
                    lualine_b = {
                        {'branch'}, {'diagnostics', sources = {'nvim_lsp'}}
                    },
                    lualine_c = {{'filename', {path = 1}}}
                }
            }
        end
    }

    -- line 'em up
    use 'godlygeek/tabular'

    -- fuzzy find
    use {
        'camspiers/snap',
        rocks = {'fzy'},
        config = function()
            local snap = require('snap')
            local fzf = snap.get('consumer.fzf')
            -- local fzy = snap.get('consumer.fzy')
            local limit = snap.get('consumer.limit')
            local rg_file = snap.get('producer.ripgrep.file')
            local rg_vimgrep = snap.get('producer.ripgrep.vimgrep').args({
                "--vimgrep", "--hidden", "--no-heading", "--with-filename",
                "--line-number", "--column", "--smart-case"
            })
            local select_file = snap.get('select.file')
            local select_vimgrep = snap.get('select.vimgrep')
            local preview_file = snap.get('preview.file')
            local preview_vimgrep = snap.get('preview.vimgrep')

            -- fuzzy find
            snap.register.map({'n'}, {'<C-p>'}, function()
                snap.run {
                    producer = fzf(rg_file),
                    select = select_file.select,
                    multiselect = select_file.multiselect,
                    views = {preview_file}
                }
            end)

            -- livegrep
            snap.register.map({'n'}, {'<leader>ag'}, function()
                snap.run {
                    producer = limit(10000, rg_vimgrep),
                    select = select_vimgrep.select,
                    multiselect = select_vimgrep.multiselect,
                    views = {preview_vimgrep}
                    -- i honestly don't know if i really ever _want_ this, and it broke
                    -- just grepping from an empty buffer.  so let's just leave it
                    -- initial_filter = vim.fn.expand('<cword>')
                }
            end)

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
        config = function() require('surround').setup({}) end
    }
    -- highlight/jump to characters in line
    use 'unblevable/quick-scope'
    -- fancy indent helper
    use 'lukas-reineke/indent-blankline.nvim'
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
    use {
        'hrsh7th/nvim-compe',
        config = function()
            require'compe'.setup {
                enabled = true,
                autocomplete = true,
                debug = false,
                min_length = 1,
                preselect = 'enable',
                throttle_time = 80,
                source_timeout = 200,
                incomplete_delay = 400,
                max_abbr_width = 100,
                max_kind_width = 100,
                max_menu_width = 100,
                documentation = true,

                source = {
                    path = true,
                    buffer = true,
                    calc = true,
                    nvim_lsp = true,
                    nvim_lua = true,
                    vsnip = true,
                    ultisnips = true
                }
            }
        end
    }
    use {
        'scalameta/nvim-metals',
        config = function()
            METALS_CONFIG = require("metals").bare_config
            METALS_CONFIG.init_options.statusBarProvider = "on"
        end
    }
    use 'alexaandru/nvim-lspupdate'
    use {'folke/trouble.nvim', config = function() require'trouble'.setup() end}
    use {
        'kabouzeid/nvim-lspinstall',
        config = function() require'lspinstall'.setup() end
    }

    -- file type icons
    use 'kyazdani42/nvim-web-devicons'

    -- file tree
    use 'kyazdani42/nvim-tree.lua'

    -- run things asynchronously
    use 'skywind3000/asyncrun.vim'

    -- neovim terminal manager
    use {
        'akinsho/nvim-toggleterm.lua',
        config = function()
            require('toggleterm').setup {
                size = 40,
                open_mapping = "<leader>`",
                insert_mappings = false
            }
        end
    }

    -- tree sitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = "all",
                highlight = {enable = true}
            }
        end
    }
    use 'nvim-treesitter/playground'

    -- autocompletes html tags
    use {
        'windwp/nvim-ts-autotag',
        config = function() require('nvim-ts-autotag').setup() end
    }

    -- markdown preview
    use {'npxbr/glow.nvim', run = ':GlowInstall'}

    -- display function signatures while typing
    use 'ray-x/lsp_signature.nvim'

    -- show pictograms on completion dropdown
    use {
        'onsails/lspkind-nvim',
        config = function() require'lspkind'.init() end
    }

    -- which key???
    use {
        'folke/which-key.nvim',
        config = function() require'which-key'.setup {} end
    }

    -- COLORSCHEMES
    use 'folke/tokyonight.nvim'
    -- use 'Shatur95/neovim-ayu'
    -- use 'bluz71/vim-nightfly-guicolors'
    -- use 'shaunsingh/nord.nvim'
    -- use 'rafamadriz/neon'
    -- use 'projekt0n/github-nvim-theme'

end)
