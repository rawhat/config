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
"Plug 'drewtempelmeyer/palenight.vim'
"Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'gruvbox-material/vim', {'as': 'gruvbox-material'}
"Plug 'haishanh/night-owl.vim'
"Plug 'morhetz/gruvbox'
"Plug 'cocopon/iceberg.vim'
"Plug 'Luxed/ayu-vim'
"Plug 'kaicataldo/material.vim'
"Plug 'ajmwagar/vim-deus'
"Plug 'NLKNguyen/papercolor-theme'
"Plug 'mhartington/oceanic-next'
"Plug 'joshdick/onedark.vim'
"Plug 'kyoz/purify', { 'rtp': 'vim' }
"Plug 'jnurmine/Zenburn'
"Plug 'dhruvasagar/vim-railscasts-theme'
"Plug 'arcticicestudio/nord-vim'
"Plug 'phanviet/vim-monokai-pro'
"Plug 'chriskempson/base16-vim'
"Plug 'mike-hearn/base16-vim-lightline'
"Plug 'nightsense/snow'
"Plug 'nightsense/cosmic_latte'
"Plug 'ajh17/Spacegray.vim'
"Plug 'romainl/Apprentice'
"Plug 'bluz71/vim-nightfly-guicolors'
"Plug 'w0ng/vim-hybrid'
"Plug 'bluz71/vim-moonfly-colors'
"Plug 'franbach/miramare'
"Plug 'sainnhe/sonokai'
"Plug 'embark-theme/vim', { 'as': 'embark' }
"Plug 'ghifarit53/tokyonight-vim'
"Plug 'tjdevries/colorbuddy.nvim'
"Plug 'marko-cerovac/material.nvim'
"Plug 'yonlu/omni.vim'
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
"" typescript
"Plug 'HerringtonDarkholme/yats.vim'
"Plug 'maxmellon/vim-jsx-pretty'
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
"Plug 'ryanoasis/vim-devicons'
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
"let g:gruvbox_contrast_dark = 'medium'
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
"let g:material_theme_style = 'darker'
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
"colorscheme base16-ocean

" snow
"set background=dark
"colorscheme snow

" cosmic_latte
"set background=dark
"colorscheme cosmic_latte

" spacegray
"let g:spacegray_use_italics = 1
"let g:spacegray_low_contrast = 1
"colorscheme spacegray

" apprentice
"colorscheme apprentice

" nightfly
"if !exists('g:colors_name')
  "let g:nightflyCursorColor = 1
  "colorscheme nightfly
"endif

" moonfly
"colorscheme moonfly
"let g:moonflyCursorColor = 1

" hybrid
"let g:hybrid_custom_term_colors = 1
"set background=dark
"colorscheme hybrid

" miramare
"let g:miramare_enable_italic = 1
"colorscheme miramare

" sonokai
"let g:sonokai_style = 'andromeda'
"let g:sonokai_style = 'atlantis'
"let g:sonokai_style = 'maia'
"let g:sonokai_style = 'shusia'
"let g:sonokai_enable_italic = 1
"let g:sonokai_disable_italic_comment = 1
"colorscheme sonokai

" embark
"let g:embark_terminal_italics = 1
"colorscheme embark

" tokyo-night
"let g:tokyonight_style = 'night'
"let g:tokyonight_style = 'storm'
"let g:tokyonight_enable_italic = 1
"colorscheme tokyonight

" other material
"let g:material_style = 'darker'
"let g:material_style = 'lighter'
"let g:material_style = 'default'
"let g:material_style = 'oceanic'
"let g:material_style = 'palenight'
"let g:material_style = 'deep ocean'
"let g:material_italic_comments = 1

" omni
"colorscheme omni

" tokyonight nvim
let g:tokyonight_style = 'night'
colorscheme tokyonight

" set backupdir=$HOME/tmp
" set directory=$HOME/tmp

set colorcolumn=81
" set column to theme black (from nightfly)
highlight ColorColumn ctermbg=0 guibg=#24283b
set number
set relativenumber

let g:jsx_ext_required = 1

" set filetypes as typescript.jsx
"autocmd BufNewFile,BufRead *.ts set filetype=typescript
"autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

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

" Lightline config
let g:lightline = {
      \ 'colorscheme': 'tokyonight',
      \ 'active': {
      \ 'left': [ ['mode', 'paste'],
      \           ['gitbranch', 'cocstatus', 'readonly', 'relativepath', 'modified']]
      \ },
      \ 'component_function': {
      \ 'gitbranch': 'fugitive#head',
      \ 'cocstatus': 'coc#status'
      \ }
      \ }
" Hide mode, because we already see it on lightline
set noshowmode

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

" Use `[g` and `]g` to navigate diagnostics
nmap <leader>k <Plug>(coc-diagnostic-prev)
nmap <leader>j <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)"
nmap <silent> <leader>co <Plug>(coc-list-outline)
"nnoremap <silent> <leader>co  :<C-u>CocList outline<CR>


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

"autocmd BufReadPost *.tsx,*.ts,*.jsx,*.js :syntax sync fromstart
"autocmd BufNewFile,BufRead *.cjs set filetype=javascript syntax=javascript
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

highlight CocErrorSign ctermfg=Red guifg=#bf616a
highlight CocWarningSign ctermfg=Yellow guifg=#ebcb8b

" get color under cursor
" :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")

let g:mix_format_on_save = 1

nmap <silent> <Leader>j <Plug>(coc-diagnostic-next)
nmap <silent> <Leader>k <Plug>(coc-diagnostic-prev)

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
