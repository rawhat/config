set nocompatible
filetype off

set encoding=utf-8

set scrolloff=3

set hlsearch
set incsearch
set showmatch
set ignorecase
set smartcase

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set wildmenu
set wildmode=longest:full,full

call plug#begin('~/.local/share/nvim/plugged')

" COLORSCHEMES
Plug 'drewtempelmeyer/palenight.vim'

" LANGUAGES
" cs
Plug 'kchmck/vim-coffee-script'
Plug 'mtscout6/vim-cjsx'
" clojure
Plug 'guns/vim-clojure-static'
" crystal
Plug 'rhysd/vim-crystal'
" csv
Plug 'chrisbra/csv.vim'
" dockerfile
Plug 'ekalinin/Dockerfile.vim'
" elixir
Plug 'elixir-editors/vim-elixir'
" elm
Plug 'ElmCast/elm-vim'
" fish
Plug 'georgewitteman/vim-fish'
" git
Plug 'tpope/vim-git'
" go
Plug 'fatih/vim-go'
" graphql
Plug 'jparise/vim-graphql'
" haskell
Plug 'neovimhaskell/haskell-vim'
" js
Plug 'Quramy/vim-js-pretty-template'
Plug 'pangloss/vim-javascript'
" json
Plug 'elzr/vim-json'
" nginx
Plug 'chr4/nginx.vim'
" nim
Plug 'zah/nim.vim'
" ocaml
Plug 'ocaml/vim-ocaml'
" psql
Plug 'lifepillar/pgsql.vim'
" proto
Plug 'uarun/vim-protobuf'
" purescript
Plug 'purescript-contrib/purescript-vim'
" python
Plug 'vim-python/python-syntax'
" reason
Plug 'reasonml-editor/vim-reason-plus'
" rust
Plug 'rust-lang/rust.vim'
" ruby
Plug 'vim-ruby/vim-ruby'
" sbt
Plug 'derekwyatt/vim-sbt'
" scala
Plug 'derekwyatt/vim-scala'
" svelte
Plug 'evanleck/vim-svelte'
" toml
Plug 'cespare/vim-toml'
" ts
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'othree/es.next.syntax.vim'
" xml
Plug 'amadeus/vim-xml'
" yaml
Plug 'stephpy/vim-yaml'

" general
Plug 'mattn/emmet-vim'

" LINTING / LS
Plug 'w0rp/ale'

" OTHER
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'lilydjwg/colorizer'
Plug 'mileszs/ack.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'raimondi/delimitmate'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'yggdroot/indentline'
Plug 'norcalli/nvim-colorizer.lua'

" buffers
Plug 'jeetsukumaran/vim-buffergator'

" coc.vim
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

call plug#end()

" CoC extensions
let g:coc_global_extensions = ['coc-tsserver', 'coc-rls', 'coc-elixir', 'coc-go', 'coc-python']

syntax enable
filetype plugin indent on

if (has("termguicolors"))
  set termguicolors
endif

" Term GUI Colors
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" use 256 colors in terminal
if !has("gui_running")
  set t_Co=256
endif

" Colorscheme stuff

" Palenight
set background=dark
colorscheme palenight
let g:palenight_terminal_italics=1

" set backupdir=$HOME/tmp
" set directory=$HOME/tmp

set colorcolumn=81
highlight ColorColumn ctermbg=1 guibg=darkgray
set number

let g:jsx_ext_required = 0

" set filetypes as typescript.jsx
autocmd BufNewFile,BufRead *.ts,*.tsx,*.jsx set filetype=typescript.tsx

let g:ale_linters = {}
let g:ale_fixers = {}
let g:indent_guides_enable_on_vim_startup=1
nnoremap <c-p> :FZF<cr>

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow'

let g:ale_javascript_eslint_use_global = 1

" `rg` searching
if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading --smart-case'
  cnoreabbrev ag Ack
endif

autocmd VimEnter * nmap <silent> <C-k> <Plug>(ale_previous_wrap)
autocmd VimEnter * nmap <silent> <C-j> <Plug>(ale_next_wrap)

nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up> :m .-2<CR>==
inoremap <A-Down> <Esc>:m .+1<CR>==gi
inoremap <A-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv
map <C-n> :NERDTreeToggle<CR>

" Lightline config
let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ 'active': {
      \ 'left': [ ['mode', 'paste'],
      \           ['gitbranch', 'cocstatus', 'readonly', 'relativepath', 'modified']]
      \ },
      \ 'component_function': {
      \ 'gitbranch': 'fugitive#head',
      \ 'cocstatus': 'coc#status'
      \ }
      \ }

" Clipboard!
set clipboard=unnamedplus

" bazel stuff
autocmd BufRead,BufNewFile *.bzl,WORKSPACE,BUILD.bazel 	setf bzl
if has("fname_case")
  " There is another check for BUILD further below.
  autocmd BufRead,BufNewFile BUILD			setf bzl
endif

" Unbind the cursor keys in insert, normal and visual modes.
for prefix in ['i', 'n', 'v', 'c']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor

" no preview
set completeopt-=preview

" coc.vim setup
set hidden

set nobackup
set nowritebackup

set updatetime=300

set shortmess+=c

set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
"
" " Use command ':verbose imap <tab>' to make sure tab is not mapped by other
" plugin.
"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

let mapleader=";"

" jsx colors
let g:vim_jsx_pretty_colorful_config=1
