require 'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
}

vim.cmd[[
  au BufRead,BufNewFile *.fish set filetype=fish
]]

require 'go'.setup()
vim.cmd[[autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()]]

-- enable completion
require 'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}

require 'lspinstall'.setup()

-- lsp config
local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')

-- https://github.com/MaskRay/ccls
require 'lspconfig'.ccls.setup {}

-- https://github.com/elbywan/crystalline
if not lspconfig.crystalline then
  configs.crystalline = {
    default_config = {
      cmd = { "crystalline" };
      filetypes = { "crystal" };
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end;
      root_patterns = { "shard.yml", ".git" };
    }
  }
end
lspconfig.crystalline.setup {}

-- https://github.com/elixir-lsp/elixir-ls
require 'lspconfig'.elixirls.setup {
  cmd = { "elixir-ls" };
}

-- npm i -g @elm-tooling/elm-language-server
require 'lspconfig'.elmls.setup {
  cmd = { "elm-language-server" },
}

require 'lspconfig'.gopls.setup {}

-- https://github.com/georgewfraser/java-language-server
if not lspconfig.java then
  configs.java = {
    default_config = {
      cmd = { "/home/alex/java-language-server/dist/lang_server_linux.sh" };
      filetypes = { "java" };
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end;
    }
  }
end
lspconfig.java.setup {}

local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
require 'lspconfig'.sumneko_lua.setup {
  cmd = {"lua-language-server", "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      filetypes = { "lua" },
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  }
}

require 'lspconfig'.zls.setup({})

vim.cmd[[
  autocmd BufNewFile,BufRead *.zig set ft=zig
  autocmd BufNewFile,BufRead *.zir set ft=zig
]]

-- `metals` covered by `nvim-metals`
-- do we really have to do this?
vim.cmd[[
  augroup lsp
    autocmd!
    autocmd FileType scala,sbt lua require("metals").initialize_or_attach(METALS_CONFIG)
  augroup end
]]
METALS_CONFIG = require("metals").bare_config
METALS_CONFIG.init_options.statusBarProvider = "on"


-- npm i -g pyright
require 'lspconfig'.pyright.setup({
  --[[ root_dir = function(filename)
    return lspconfig.util.path.dirname(filename)
  end ]]
  root_dir = function(fname)
    return lspconfig.util.root_pattern(".git", "setup.py",  "setup.cfg", "pyproject.toml", "requirements.txt")(fname) or
      lspconfig.util.path.dirname(fname)
  end
})

-- pipx install 'python-language-server[all]'
-- require 'lspconfig'.pyls.setup({})

-- https://rust-analyzer.github.io/manual.html#installation
require 'lspconfig'.rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      }
    }
  }
})

-- npm i -g typescript-language-server
require 'lspconfig'.tsserver.setup({})

require 'trouble'.setup()

-- require 'lsp_signature'.on_attach()

require 'lspkind'.init()

require('lualine').setup {
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
}

vim.g.surround_pairs = {
  nestable = {
    {"(", ")"},
    {"[", "]"},
    {"{", "}"},
  },
  linear = {
    {"'", "'"},
    {'"', '"'},
    {" ", " "},
    {"`", "`"}
  }
}
require('surround').setup {}

require('nvim-ts-autotag').setup()

require('toggleterm').setup {
  size = 40,
  open_mapping = "<leader>`",
  insert_mappings = false,
}

local snap = require('snap')
local fzf = snap.get('consumer.fzf')
-- local fzy = snap.get('consumer.fzy')
local limit = snap.get('consumer.limit')
local rg_file = snap.get('producer.ripgrep.file')
local rg_vimgrep = snap.get('producer.ripgrep.vimgrep').args({
  "--vimgrep",
  "--hidden",
  "--no-heading",
  "--with-filename",
  "--line-number",
  "--column",
  "--smart-case"
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
    views = { preview_file }
  }
end)

-- livegrep
snap.register.map({'n'}, {'<leader>ag'}, function()
  snap.run {
    producer = limit(10000, rg_vimgrep),
    select = select_vimgrep.select,
    multiselect = select_vimgrep.multiselect,
    views = { preview_vimgrep },
    initial_filter = vim.fn.expand('<cword>')
  }
end)

require 'which-key'.setup {}

vim.api.nvim_exec([[
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>
]], false)

vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankLine_char = "│"
-- vim.g["indent_blankline_space_char"] = "·"

vim.g.buftabline_numbers = 1
vim.g.buftabline_separators = 1

-- vim.g["gitgutter_map_keys"] = 0
require('gitsigns').setup()

vim.g.node_client_debug = 1

vim.cmd[[filetype plugin indent on]]

-- Might be unnecessary post-treesitter
vim.g.jsx_ext_required = 1

-- Needed?
vim.cmd[[
  au BufRead,BufNewFile *.go set filetype=go
]]

vim.cmd[[
  autocmd BufNewFile,BufRead *.ex set ft=elixir
  autocmd BufNewFile,BufRead *.exs set ft=elixir
]]

-- Indent lines
vim.g.indent_guides_enable_on_vim_startup = 1
vim.g.indentLine_char_list = {'▏'}

-- Using `ripgrep` for searching
vim.g.ackprg = "rg --vimgrep --no-heading --smart-case"
vim.cmd[[cnoreabbrev rg Ack]]

vim.g.mix_format_on_save = 1

-- asyncrun
vim.g.asyncrun_open = 10
vim.g.asyncrun_local = 1

vim.cmd[[cnoreabbrev ar AsyncRun]]

-- fzf
vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow'

-- which key

-- Theme
-- vim.cmd[[colorscheme nightfly]]

vim.g.tokyonight_style = "night"
vim.cmd[[colorscheme tokyonight]]

-- vim.g.ayu_mirage = true
-- vim.cmd[[colorscheme ayu]]

-- require('nord').set()

-- "default", "dark", "doom"
-- vim.g.neon_style = "dark"
-- vim.cmd[[colorscheme neon]]
