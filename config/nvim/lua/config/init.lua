vim.cmd[[
  au BufRead,BufNewFile *.fish set filetype=fish
]]

-- lsp config
local lspconfig = require('lspconfig')

local crystalline_config = {
  cmd = { "crystalline" };
  filetypes = { "crystal" };
  root_dir = function(fname)
    return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
  end;
  root_patterns = { "shard.yml", ".git" };
}

local erlang_config = {
  cmd = { "erlang_ls" };
  filetypes = { "erlang" };
  root_dir = function(fname)
    return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
  end;
  root_patterns = { "rebar.config", ".git" };
}

local elixirls_config = {
  cmd = { "elixir-ls" };
}

local javals_config = {
  cmd = { "/home/alex/java-language-server/dist/lang_server_linux.sh" };
  filetypes = { "java" };
  root_dir = function(fname)
    return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
  end;
}

local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local luals_config = {
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

local function setup_servers()
  require 'lspinstall'.setup()

  local configs = require 'lspconfig/configs'

  local servers = require 'lspinstall'.installed_servers()
  table.insert(servers, "crystalline")
  table.insert(servers, "erlang")
  table.insert(servers, "java")

  for _, server in pairs(servers) do
    Config = {}
    if server == "crystalline" then
      configs.crystalline = {
        default_config = crystalline_config
      }
    end
    if server == "erlang" then
      configs.erlang = {
        default_config = erlang_config;
      }
    end
    if server == "elixirls" then
      Config = elixirls_config
    end
    if server == "java" then
      configs.java = {
        default_config = javals_config
      }
    end
    if server == "lua" then
      Config = luals_config
    end

    lspconfig[server].setup(Config)
  end
end

setup_servers()

require 'lspinstall'.post_install_hook = function ()
  setup_servers()
  vim.cmd("bufdo e")
end

-- require 'lspconfig'.zls.setup({})

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

-- require 'lsp_signature'.on_attach()

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

-- require('github-theme').setup()
