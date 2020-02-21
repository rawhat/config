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
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'gruvbox-material/vim', {'as': 'gruvbox-material'}
Plug 'haishanh/night-owl.vim'
Plug 'morhetz/gruvbox'
Plug 'cocopon/iceberg.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'kaicataldo/material.vim'
Plug 'ajmwagar/vim-deus'
Plug 'NLKNguyen/papercolor-theme'
Plug 'mhartington/oceanic-next'
Plug 'joshdick/onedark.vim'
Plug 'kyoz/purify', { 'rtp': 'vim' }
Plug 'jnurmine/Zenburn'
Plug 'dhruvasagar/vim-railscasts-theme'
Plug 'arcticicestudio/nord-vim'
Plug 'phanviet/vim-monokai-pro'
Plug 'chriskempson/base16-vim'
Plug 'mike-hearn/base16-vim-lightline'

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
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
" graphql
Plug 'jparise/vim-graphql'
" haskell
Plug 'neovimhaskell/haskell-vim'
" js
Plug 'othree/yajs.vim'
" json
Plug 'elzr/vim-json'
" jsonnet
Plug 'google/vim-jsonnet'
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
" Pug
Plug 'digitaltoad/vim-pug'
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
" scss
Plug 'cakebaker/scss-syntax.vim'
" scala
Plug 'derekwyatt/vim-scala'
" svelte
Plug 'evanleck/vim-svelte'
" toml
Plug 'cespare/vim-toml'
" ts
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
" xml
Plug 'amadeus/vim-xml'
" yaml
Plug 'stephpy/vim-yaml'

" # general
" emmet
Plug 'mattn/emmet-vim'
" * for visual selections
Plug 'nelstrom/vim-visual-star-search'
" :noh on cursor move
Plug 'haya14busa/is.vim'
" run tests
Plug 'janko/vim-test'
" shell commands
Plug 'tpope/vim-eunuch'

" LINTING / LS
"Plug 'w0rp/ale'

" OTHER
" displays symbols on site for add/delete/change
Plug 'airblade/vim-gitgutter'
" modified status bar
Plug 'itchyny/lightline.vim'
" line 'em up
Plug 'godlygeek/tabular'
" fuzzy find
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" search!
Plug 'mileszs/ack.vim'
" highlights trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
" auto-add matching symbols (, ", etc
Plug 'raimondi/delimitmate'
" ez commenting
Plug 'scrooloose/nerdcommenter'
" git good
Plug 'tpope/vim-fugitive'
" ("'happy times'")
Plug 'machakann/vim-sandwich'
" highlight/jump to characters in line
Plug 'unblevable/quick-scope'
" fancy indent helper
Plug 'yggdroot/indentline'
" highlights hex colors rgb(200, 200, 200)
Plug 'norcalli/nvim-colorizer.lua'
" displays buffers at the top
Plug 'ap/vim-buftabline'

" markdown
"Plug 'plasticboy/vim-markdown'

" buffers
Plug 'jeetsukumaran/vim-buffergator'

" coc.vim
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

call plug#end()

" CoC extensions
let g:coc_global_extensions = [
      \ 'coc-eslint',
      \ 'coc-tsserver',
      \ 'coc-rls',
      \ 'coc-elixir',
      \ 'coc-go',
      \ 'coc-python',
      \ 'coc-yaml'
      \ ]

filetype plugin indent on

syntax on
set termguicolors

" Term GUI Colors
"if (has("nvim"))
  ""For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  "let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"endif

" use 256 colors in terminal
"if !has("gui_running")
set t_Co=256
"endif

" Colorscheme stuff

" Palenight
"let g:palenight_terminal_italics=1
"set background=dark
"colorscheme palenight

" Dracula
"colorscheme dracula

" Gruvbox Material
"set background=dark
"let g:gruvbox_material_background = 'hard'
"colorscheme gruvbox-material

" Night Owl
"colorscheme night-owl

" Gruvbox
"let g:gruvbox_contrast_dark = 'hard'
"let g:gruvbox_contrast = 'hard'
"let g:gruvbox_bold = 1
"let g:gruvbox_italic = 1
"set background=dark
"colorscheme gruvbox

" Iceberg
" colorscheme iceberg

" Ayu
"let ayucolor="mirage"
"let ayucolor="dark"
"colorscheme ayu

" Material
"let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker'
"let g:material_theme_style = 'palenight'
"let g:material_theme_style = 'palenight'
"let g:material_terminal_italics = 1
"colorscheme material

" Deus
"set background=dark
"colors deus
"let g:deus_termcolors=256

" PaperColor
"set background=dark
"colorscheme PaperColor

"Oceanic Next
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"colorscheme OceanicNext

" OneDark
"let g:onedark_terminal_italics=1
"colorscheme onedark

" purify
"colorscheme purify

" Zenburn
"colorscheme zenburn

" railscasts
"colorscheme railscasts

" nord
"colorscheme nord

" monokai pro
"colorscheme monokai_pro

" base-16
colorscheme base16-ocean

" set backupdir=$HOME/tmp
" set directory=$HOME/tmp

set colorcolumn=81
highlight ColorColumn ctermbg=1 guibg=darkgray
set number
set relativenumber

let g:jsx_ext_required = 1

" set filetypes as typescript.jsx
autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

au BufRead,BufNewFile *.go set filetype=go

let g:ale_linters = {'py': ['pylint']}
let g:ale_fixers = {}
let g:indent_guides_enable_on_vim_startup=1
let g:indentLine_char_list = ['▏'] ", '┆', '┊', '|']
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
"map <C-n> :NERDTreeToggle<CR>

"     \ 'colorscheme': 'palenight',
" Lightline config
let g:lightline = {
      \ 'colorscheme': 'base16_oceanicnext',
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

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <silent> gd <Plug>(coc-definition)

let mapleader=";"

nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

" jsx colors
let g:vim_jsx_pretty_colorful_config=1

" Don't fold
"let g:vim_markdown_folding_disabled=1
"let g:vim_markdown_folding_style_pythonic = 1

" python colors
let g:python_highlight_all=1

" golang
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
" was slow with these
"let g:go_highlight_extra_types = 1
"let g:go_highlight_build_constraints = 1
"let g:go_highlight_generate_tags = 1
let g:go_code_completion_enabled = 0

" vim-js-pretty-template
"autocmd FileType javascript JsPreTmpl
"autocmd FileType javascript.jsx JsPreTmpl
"autocmd FileType typescript JsPreTmpl
"autocmd FileType typescript.tsx JsPreTmpl

" json
let g:vim_json_syntax_conceal = 0

" rust
let g:rustc_path = trim(system('which rustc'))

"autocmd BufReadPost *.tsx,*.ts,*.jsx,*.js :syntax sync fromstart
autocmd BufNewFile,BufRead *.cjs set filetype=javascript syntax=javascript
autocmd BufNewFile,BufRead *.jade set filetype=pug

" italics fixes
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" test
function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
map gm :call SynStack()<CR>

" file explorer
map <C-n> :Lexplore<CR>
let g:netrw_winsize=25

" emmet
autocmd FileType html,css,javascript.jsx,typescript.react,typescript.tsx EmmetInstall
let g:user_emmet_settings = {
\ 'typescript' : {
\     'extends' : 'jsx',
\ },
\ 'typescript.tsx' : {
\     'extends' : 'jsx',
\ },
\}
