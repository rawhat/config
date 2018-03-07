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

set wildmenu
set wildmode=longest:full,full

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
call plug#begin('~/.vim/plugged')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plug 'VundleVim/Vundle.vim'
Plug 'mtscout6/vim-cjsx'
Plug 'kchmck/vim-coffee-script'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
"Plug 'derekwyatt/vim-scala'
Plug 'w0rp/ale'
Plug 'ntpeters/vim-better-whitespace'
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'mru.vim'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install -all'}
Plug 'junegunn/fzf.vim'
"Plug 'scrooloose/nerdtree'
"Plug 'valloric/youcompleteme'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'raimondi/delimitmate'
Plug 'joshdick/onedark.vim'
Plug 'jpo/vim-railscasts-theme'
Plug 'mhartington/oceanic-next'
Plug 'sheerun/vim-polyglot'
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'mxw/vim-jsx'
Plug 'yggdroot/indentline'
"Plug 'ianks/vim-tsx'
Plug 'ajmwagar/vim-deus'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'unblevable/quick-scope'
Plug 'lilydjwg/colorizer'
Plug 'nightsense/seagrey'
Plug 'nightsense/carbonized'
Plug 'nightsense/forgotten'
Plug 'nightsense/nemo'
Plug 'nightsense/office'
Plug 'nightsense/vrunchbang'
Plug 'rakr/vim-one'
Plug 'nanotech/jellybeans.vim'
Plug 'chriskempson/base16-vim'
"Plug 'Quramy/tsuquyomi'
Plug 'Quramy/vim-js-pretty-template'
"call vundle#end()
call plug#end()

syntax on
filetype plugin indent on

" Colorscheme stuff
"
" GRUVBOX
colorscheme gruvbox
set background=dark
"
" OCEANIC NEXT
"if (has("termguicolors"))
  "set termguicolors
"endif
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

"let g:tagbar_type_coffee = {
"      \ 'ctagstype' : 'coffee',
"      \ 'kinds' : [
"      \   'c:classes',
"      \   'f:functions',
"      \   'v:variables'
"      \ ],
"      \ }
"
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_coffee_checkers = ['coffeelint']
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"set backupdir=$HOME/tmp
"set directory=$HOME/tmp
set colorcolumn=81
set number
set ts=2 sw=2 et
set softtabstop=2

" Term GUI Colors
if (has("nvim"))
"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
"if (has("termguicolors"))
  "set termguicolors
"endif

" use 256 colors in terminal
"if !has("gui_running")
  "set t_Co=256
  "set term=screen-256color
"endif

let g:jsx_ext_required = 0

let g:ale_linters = {'coffee': ['coffeelint'], 'js': ['eslint'], 'ts': ['tslint'], 'tsx': ['tslint']}
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors=1
"let g:ctrlp_map='<c-p>'
"let g:ctrlp_cmd='CtrlP'
"let g:ctrlp_custom_ignore='node_modules'
set rtp+=~/.fzf
nnoremap <c-p> :FZF<cr>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

let g:ale_javascript_eslint_use_global = 1

if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
  cnoreabbrev ag Ack
  cnoreabbrev aG Ack
  cnoreabbrev Ag Ack
  cnoreabbrev AG Ack
endif

let g:indentLine_setColors = 0

autocmd VimEnter * nmap <silent> <C-k> <Plug>(ale_previous_wrap)
autocmd VimEnter * nmap <silent> <C-j> <Plug>(ale_next_wrap)

nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up> :m .-2<CR>==
inoremap <A-Down> <Esc>:m .+1<CR>==gi
inoremap <A-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv
map <C-n> :NERDTreeToggle<CR>
