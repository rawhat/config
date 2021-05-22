local vim = vim

-- tree-sitter
-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.elixir = {
--   install_info = {
--     url = "~/tree-sitter-elixir",
--     files = {"src/parser.c", "src/scanner.cc"},
--   },
--   filetype = "elixir",
--   used_by = {},
-- }

require 'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
}

require 'go'.setup()
vim.cmd[[autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()]]

-- enable compltion
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
  -- cmd = { "/home/alex/bin/elixir-ls/language_server.sh" };
  --[[ settings = {
    filetypes = { "elixir" };
    root_dir = function(name)
      return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
    end;
  } ]]
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

-- `metals` covered by `nvim-metals`

-- npm i -g pyright
require 'lspconfig'.pyright.setup {}

-- https://rust-analyzer.github.io/manual.html#installation
require 'lspconfig'.rust_analyzer.setup {
  settings = {
    ["rust-analyzer"] = {
      ["checkOnSave.command"] = "clippy"
    }
  }
}

-- npm i -g typescript-language-server
require 'lspconfig'.tsserver.setup {}

require 'trouble'.setup()

-- require 'lsp_signature'.on_attach()

require 'lspkind'.init()

require('lualine').setup {
  options = { theme = 'nightfly' },
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

require('surround').setup {}
vim.g.surround_pairs = {
  nestable = {
    {"(", ")"},
    {"[", "]"},
    {"{", "}"}
  },
  linear = {
    {"'", "'"},
    {'"', '"'},
    {" ", " "}
  }
}

require('nvim-ts-autotag').setup()

require('toggleterm').setup {
  size = 40,
  open_mapping = "<leader>`",
}

require('telescope').setup {
  extensions = {
    fzf = {
      override_generic_sorter = true,
      override_file_sorter = true,
      -- case_mode = "smart_case",
    }
  }
}
require('telescope').load_extension('fzf')

vim.api.nvim_exec([[
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>
]], false)

vim.g["indent_blankline_show_first_indent_level"] = false
-- vim.g["indent_blankline_space_char"] = "·"

vim.g["buftabline_numbers"] = 1
vim.g["buftabline_separators"] = 1

vim.g["gitgutter_map_keys"] = 0

vim.g["node_client_debug"] = 1

vim.cmd[[filetype plugin indent on]]

-- Might be unnecessary post-treesitter
vim.g["jsx_ext_required"] = 1

-- Needed?
vim.cmd[[
  au BufRead,BufNewFile *.go set filetype=go
]]

vim.cmd[[
  autocmd BufNewFile,BufRead *.ex set ft=elixir
  autocmd BufNewFile,BufRead *.exs set ft=elixir
]]

-- Indent lines
vim.g["indent_guides_enable_on_vim_startup"] = 1
vim.g["indentLine_char_list"] = {'▏'}

-- Using `ripgrep` for searching
vim.g["ackprg"] = "rg --vimgrep --no-heading --smart-case"
vim.cmd[[cnoreabbrev rg Ack]]

vim.g["mix_format_on_save"] = 1

-- asyncrun
vim.g["asyncrun_open"] = 10
vim.g["asyncrun_local"] = 1

vim.cmd[[cnoreabbrev ar AsyncRun]]

-- fzf
vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow'

-- Theme
vim.cmd[[colorscheme nightfly]]

-- vim.g["tokyonight_style"] = "night"
-- vim.cmd[[colorscheme tokyonight]]

-- vim.g.ayu_mirage = true
-- vim.cmd[[colorscheme ayu]]

-- require('nord').set()
