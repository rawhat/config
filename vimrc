set nocompatible              " be iMproved, required
filetype off                  " required

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

call plug#begin('~/.vim/plugged')

" COLORSCHEMES
Plug 'tyrannicaltoucan/vim-quantum'
"Plug 'morhetz/gruvbox'
"Plug 'ajmwagar/vim-deus'
"Plug 'jacoborus/tender.vim'
"Plug 'srcery-colors/srcery-vim'
"Plug 'arcticicestudio/nord-vim'
"Plug 'ayu-theme/ayu-vim'
"Plug 'drewtempelmeyer/palenight.vim'
"Plug 'junegunn/seoul256.vim'
"Plug 'joshdick/onedark.vim'
"Plug 'jpo/vim-railscasts-theme'
"Plug 'mhartington/oceanic-next'
"Plug 'nightsense/seagrey'
"Plug 'nightsense/carbonized'
"Plug 'nightsense/forgotten'
"Plug 'nightsense/nemo'
"Plug 'nightsense/office'
"Plug 'nightsense/vrunchbang'
"Plug 'rakr/vim-one'
"Plug 'nanotech/jellybeans.vim'
"Plug 'chriskempson/base16-vim'

" LANGUAGES

" js
Plug 'Quramy/vim-js-pretty-template'
Plug 'othree/es.next.syntax.vim'
"Plug 'mxw/vim-jsx'
"Plug 'othree/yajs.vim'

" cs
Plug 'kchmck/vim-coffee-script'
Plug 'mtscout6/vim-cjsx'

" ts
"Plug 'Shougo/deoplete.nvim'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
"Plug 'HerringtonDarkholme/yats.vim'
"Plug 'mhartington/nvim-typescript', { 'build': './install.sh', 'for': ['typescript', 'typescript.tsx']}
"Plug 'mhartington/nvim-typescript', { 'build': './install.sh' }
"Plug 'peitalin/vim-jsx-typescript'
"Plug 'ianks/vim-tsx'

" general
Plug 'sheerun/vim-polyglot'
"Plug 'derekwyatt/vim-scala'

" LINTING / LS
Plug 'w0rp/ale'
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'Quramy/tsuquyomi'

" OTHER
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
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
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'ctrlpvim/ctrlp.vim'

" Completion packages "
Plug 'unblevable/quick-scope'
Plug 'valloric/youcompleteme'
Plug 'yggdroot/indentline'
"Plug 'zxqfl/tabnine-vim'

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
  "set term=screen-256color
  "set cterm=screen-256color
endif

" Colorscheme stuff
"
" GRUVBOX
"set background=dark
"let g:gruvbox_constrast_dark='hard'
"colorscheme gruvbox
"
" OCEANIC NEXT
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"colorscheme OceanicNext
"
" ONE DARK
"colorscheme onedark
"let g:airline_theme='onedark'
"
" RAILSCASTS
"colorscheme railscasts
"
" Nightsense Themes
"colorscheme seagrey-dark
"colorscheme carbonized-dark
"colorscheme forgotten-dark
"colorscheme nemo-dark
"colorscheme office-dark
"colorscheme vrunchbang-dark
"
" vim-one
"colorscheme one
"set background=dark
"
" jellybeans
"colorscheme jellybeans
"let g:jellybeans_use_term_italics = 1
"
" base16
"colorscheme base16-default-dark
"
"deus
"set t_Co=256
"set termguicolors
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"set background=dark " Setting dark mode
"colorscheme deus
"let g:deus_termcolors=256
" toothpaste
"colorscheme toothpaste

" Seoul256
"colo seoul256
"let g:seoul256_background = 235
"let g:seoul256_srgb = 1

" Quantum
set background=dark
let g:quantum_black=1
let g:quantum_italics=1
let g:airline_theme='quantum'
colorscheme quantum

" Tender
"colorscheme tender
"let g:airline_theme='tender'

" Srcery
"colorscheme srcery
"let g:airline_theme='srcery'

" Nord
"let g:nord_italic=1
"let g:nord_italic_comments=1
"let g:airline_theme='nord'
"colorscheme nord

" Ayu
"let ayucolor='mirage'
"let ayucolor='dark'
"colorscheme ayu

" Palenight
"set background=dark
"let g:airline_theme='palenight'
"colorscheme palenight


set backupdir=$HOME/tmp
set directory=$HOME/tmp

set colorcolumn=81
highlight ColorColumn ctermbg=0 guibg=darkgrey
set number


let g:jsx_ext_required = 0

" deoplete (for nvim-typescript)
"let g:deoplete#enable_at_startup=1

" set filetypes as typescript.jsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" match opening JSX tag color
"hi link xmlEndTag xmlTag
"highlight link xmlEndTag xmlTag
"hi Tag        ctermfg=04
"hi xmlTag     ctermfg=04
"hi xmlTagName ctermfg=04
"hi xmlEndTag  ctermfg=04

let g:ale_linters = {'coffee': ['coffeelint'], 'js': ['eslint'], 'typescript': ['tsserver']}
let g:ale_typescript_tsserver_use_global=1
let g:indent_guides_enable_on_vim_startup=1
nnoremap <c-p> :FZF<cr>
"let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow'

let g:ale_javascript_eslint_use_global = 1

let g:polyglot_disabled = ['python-indent', 'typescript-vim']
"let g:polyglot_disabled = ['python-indent']

if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
  cnoreabbrev ag Ack
  cnoreabbrev aG Ack
  cnoreabbrev Ag Ack
  cnoreabbrev AG Ack
endif

"let g:indentLine_setColors = 1

autocmd VimEnter * nmap <silent> <C-k> <Plug>(ale_previous_wrap)
autocmd VimEnter * nmap <silent> <C-j> <Plug>(ale_next_wrap)

nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up> :m .-2<CR>==
inoremap <A-Down> <Esc>:m .+1<CR>==gi
inoremap <A-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv
map <C-n> :NERDTreeToggle<CR>

" Fix background
"let &t_ut=''

" YCM stuff
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_global_ycm_extra_conf = '/home/amanning/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0
let g:ycm_collect_identifiers_from_tag_files = 1
set completeopt=longest,menu
set shortmess+=c
