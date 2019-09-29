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

" js
Plug 'Quramy/vim-js-pretty-template'
Plug 'othree/es.next.syntax.vim'

" cs
Plug 'kchmck/vim-coffee-script'
Plug 'mtscout6/vim-cjsx'

" ts
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
"Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }

" python
" Plug 'zchee/deoplete-jedi'

" scala
"Plug 'derekwyatt/vim-scala'

" general
Plug 'sheerun/vim-polyglot'

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

" coc.vim
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" coc extensions
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}

" Not working with Plug (yet?)
"Plug 'neoclide/coc-elixir', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-go', {'do': 'yarn install --frozen-lockfile'}

call plug#end()

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

" set filetypes as scala
au BufRead,BufNewFile *.sbt set filetype=scala

    " \ 'py': ['pylint'],
let g:ale_linters = {
      \ 'js': ['eslint'],
      \ 'typescript': ['tsserver']
      \ }
let g:ale_go_langserver_executable = 'gopls'
let g:ale_typescript_tsserver_use_global=1
let g:indent_guides_enable_on_vim_startup=1
nnoremap <c-p> :FZF<cr>

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow'

let g:ale_javascript_eslint_use_global = 1

let g:polyglot_disabled = ['python-indent', 'typescript-vim']
" `rg` searching
if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
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

" Deoplete stuff
" let g:deoplete#enable_at_startup = 1
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

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

set cmdheight=2

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
