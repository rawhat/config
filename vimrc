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
Plug 'folke/tokyonight.nvim'

" LANGUAGES
" cs
Plug 'kchmck/vim-coffee-script'
Plug 'mtscout6/vim-cjsx'
"" crystal
Plug 'rhysd/vim-crystal'
"" csv
Plug 'chrisbra/csv.vim'
"" dockerfile
Plug 'ekalinin/Dockerfile.vim'
"" elixir
Plug 'elixir-editors/vim-elixir'
"" fish
Plug 'georgewitteman/vim-fish'
"" fsharp
Plug 'kongo2002/fsharp-vim'
"" git
Plug 'tpope/vim-git'
"" gleam
Plug 'gleam-lang/gleam.vim'
"" jsonnet
Plug 'google/vim-jsonnet'
"" nginx
Plug 'chr4/nginx.vim'
"" nim
Plug 'zah/nim.vim'
"" psql
Plug 'lifepillar/pgsql.vim'
"" proto
Plug 'uarun/vim-protobuf'
"" Pug
Plug 'digitaltoad/vim-pug'
"" purescript
Plug 'purescript-contrib/purescript-vim'
"" reason
Plug 'reasonml-editor/vim-reason-plus'
"" sbt
Plug 'derekwyatt/vim-sbt'
"" scss
Plug 'cakebaker/scss-syntax.vim'
"" xml
Plug 'amadeus/vim-xml'

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
"Plug 'itchyny/lightline.vim'
Plug 'hoob3rt/lualine.nvim'
" line 'em up
Plug 'godlygeek/tabular'
" fuzzy find
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
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
" `mix format`
Plug 'mhinz/vim-mix-format'
" adjust color scheme
Plug 'zefei/vim-colortuner'

" buffers
Plug 'jeetsukumaran/vim-buffergator'

" coc.vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" file type icons
Plug 'kyazdani42/nvim-web-devicons'

" project file browser
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'

" run things asynchronously
Plug 'skywind3000/asyncrun.vim'

" neovim terminal manager
Plug 'kassio/neoterm'

" tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

call plug#end()

" CoC extensions
let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-rust-analyzer',
      \ 'coc-elixir',
      \ 'coc-python',
      \ 'coc-yaml',
      \ 'coc-fsharp',
      \ 'coc-prettier'
      \ ]

filetype plugin indent on

" re-sourcing fix
if !exists('g:syntax_on')
  syntax on
  let g:syntax_on = 1
end

set termguicolors

set t_Co=256

" Colorscheme stuff
let g:tokyonight_style = 'night'
colorscheme tokyonight

set colorcolumn=81
highlight ColorColumn ctermbg=0 guibg=#24283b
set number
set relativenumber

let g:jsx_ext_required = 1

au BufRead,BufNewFile *.go set filetype=go

let g:indent_guides_enable_on_vim_startup=1
let g:indentLine_char_list = ['▏']
nnoremap <c-p> :FZF<cr>

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow'

" `rg` searching
if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading --smart-case'
  cnoreabbrev rg Ack
endif

nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up> :m .-2<CR>==
inoremap <A-Down> <Esc>:m .+1<CR>==gi
inoremap <A-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv

" fern
map <C-n> :Fern . -drawer -toggle -reveal=%<CR>
let g:fern#renderer = "nerdfont"

function! s:init_fern() abort
  nmap <buffer><expr> l fern#smart#leaf('<Plug>(fern-action-open)', '<Plug>(fern-action-expand)', '<Plug>(fern-action-collapse)')
endfunction

augroup my-fern
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

" Clipboard!
set clipboard=unnamedplus

" bazel stuff
autocmd BufRead,BufNewFile *.bzl,WORKSPACE,BUILD.bazel 	setf bzl
if has("fname_case")
  " There is another check for BUILD further below.
  autocmd BufRead,BufNewFile BUILD			setf bzl
endif

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

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <leader>k <Plug>(coc-diagnostic-prev)
nmap <leader>j <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)"
nmap <silent> <leader>co <Plug>(coc-list-outline)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end'

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

let mapleader=";"

nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

" json
let g:vim_json_syntax_conceal = 0

" rust
let g:rustc_path = trim(system('which rustc'))

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

let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"

"highlight CocErrorSign ctermfg=Red guifg=#bf616a
"highlight CocWarningSign ctermfg=Yellow guifg=#ebcb8b

let g:mix_format_on_save = 1

" debug
let g:node_client_debug = 1

" fix CRA reloading
set backupcopy=yes

" open quickfix window when asyncrun
let g:asyncrun_open = 10
" use local errorformat
let g:asyncrun_local = 1
" shortcut for if i'm lazy
cnoreabbrev ar AsyncRun
" some bindings for running/stopping
nmap <silent> <Leader>ar :AsyncRun
nmap <silent> <Leader>aw :AsyncRun -raw
nmap <silent> <Leader>as :AsyncStop
" shortcuts to open/close
nmap <silent> <Leader>co :copen<CR>
nmap <silent> <Leader>cc :cclose<CR>

" disable nerdcommenter bindings to avoid clashes with <Leader>cc above
let g:NERDCreateDefaultMappings = 0
vmap <Leader>c<space> <Plug>NERDCommenterToggle
nmap <Leader>c<space> <Plug>NERDCommenterToggle

let g:term_buf = 1

execute 'nnoremap <silent> <Leader>` :botright ' . g:term_buf . 'Ttoggle resize=20<CR>'
execute 'tnoremap <silent> <Leader>` :botright ' . g:term_buf . 'Ttoggle resize=20<CR>'

nnoremap <silent> <Leader>m` <C-W>T
" properly bind esc if it's not neovim
if has("nvim")
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>
endif
