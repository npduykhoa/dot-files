call plug#begin(expand('~/.config/nvim/plugged'))

"************************************************
"(                Vim Plugins                   )
"************************************************

"---Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' | Plug 'jiangmiao/auto-pairs' | Plug 'alvan/vim-closetag'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } | Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Greeting Screen
Plug 'mhinz/vim-startify'

" Themes
Plug 'morhetz/gruvbox' | Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

" Highlight Tokens
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Popup
Plug 'voldikss/vim-floaterm'

" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'

" Git
Plug 'f-person/git-blame.nvim' | Plug 'tpope/vim-fugitive' | Plug 'airblade/vim-gitgutter', {'branch': 'master'}

" Diffview
Plug 'nvim-lua/plenary.nvim' | Plug 'sindrets/diffview.nvim'

" Coc vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"***********************************************
"(                Basic Setup                  )
"***********************************************

let mapleader=' '

nmap <leader>w :w<CR>
nmap <leader>e :q!<CR>

set clipboard+=unnamedplus

set number
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set hidden
set laststatus=2
set updatetime=300
set autoread
set lazyredraw

"---Search keyword & replace all in file---
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

"---DiffView---
nmap dc :DiffviewClose<CR>
nmap do :DiffviewOpen<CR>
nmap dh :DiffviewFileHistory<CR>

"---Themes---
syntax enable
set background=dark
color gruvbox

"---Navigation Panel---
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-v> <C-w>v
nnoremap <C-s> <C-w>s

"---Auto Complete & Import---
inoremap <silent><expr> <C-space> coc#refresh()
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<C-g>u\<TAB>"

"**********************************************
"(            Plugins Configuration           )
"**********************************************

"---FloatTerm---
let g:floaterm_keymap_toggle = '<leader>ft'
let g:floaterm_gitcommit='floaterm'
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1
let g:floaterm_completeoptPreview=1

"---Airline---
let g:airline_theme='molokai'
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = 'ln'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'
let g:airline_symbols.colnr='col'"
let g:airline#extensions#tabline#enabled = 1

lua << EOF

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}

EOF

"---Nerd Tree---
autocmd VimEnter * NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>u :vertical resize +10<CR>
nnoremap <leader>d :vertical resize -10<CR>

"---Fuzzy Search & Ripgrep---
nnoremap <silent> <C-S-p> :Files<CR>
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path '**/node_modules/**' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --fixed-strings ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <silent> <leader>f :Rg<CR>

"---Prettier---
"command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
"let g:prettier#autoformat = 1
"let g:prettier#autoformat_require_pragma = 0

"---Startify---
let g:startify_change_to_dir = 0
let s:header = [
\'                                                                                                                                ▄▄▄▄▄▄▄▄▄             ',
\' ███████████████████████████                                                                                                 ▄█████████████▄          ',
\' ███████▀▀▀░░░░░░░▀▀▀███████                                    [ Author: npduykhoa ]                                █████  █████████████████  █████  ',
\' ████▀░░░░░░░░░░░░░░░░░▀████                                                                                         ▐████▌ ▀███▄       ▄███▀ ▐████▌  ',
\' ███│░░░░░░░░░░░░░░░░░░░│███                      __         _    _         _    _      _         _                   █████▄  ▀███▄   ▄███▀  ▄█████   ',
\' ██▌│░░░░░░░░░░░░░░░░░░░│▐██                     / /    ___ | |_ ( ) ___   | |_ | |__  (_) _ __  | | __               ▐██▀███▄  ▀███▄███▀  ▄███▀██▌   ',
\' ██░└┐░░░░░░░░░░░░░░░░░┌┘░██                    / /    / _ \| __||/ / __|  | __|| |_ \ | || |_ \ | |/ /                ███▄▀███▄  ▀███▀  ▄███▀▄███    ',
\' ██░░└┐░░░░░░░░░░░░░░░┌┘░░██                   / /___ |  __/| |_    \__ \  | |_ | | | || || | | ||   <                 ▐█▄▀█▄▀███ ▄ ▀ ▄ ███▀▄█▀▄█▌    ',
\' ██░░┌┘▄▄▄▄▄░░░░░▄▄▄▄▄└┐░░██                   \____/  \___| \__|   |___/   \__||_| |_||_||_| |_||_|\_\                 ███▄▀█▄██ ██▄██ ██▄█▀▄███     ',
\' ██▌░│██████▌░░░▐██████│░▐██                                                                                             ▀███▄▀██ █████ ██▀▄███▀      ',
\' ███░│▐███▀▀░░▄░░▀▀███▌│░███                                  00:00 ━━━━━━●───── 15:08                                  █▄ ▀█████ █████ █████▀ ▄█     ',
\' ██▀─┘░░░░░░░▐█▌░░░░░░░└─▀██                                         ⇆ ◁ ㅤ❚❚ ▷ ↻                                         ███        ███        ███     ',
\' ██▄░░░▄▄▄▓░░▀█▀░░▓▄▄▄░░░▄██                        +--------------------------------------------+                      ███▄    ▄█ ███ █▄    ▄███     ',
\' ████▄─┘██▌░░░░░░░▐██└─▄████                        | "Khi ta không làm ra tiền nghĩa là ta đang |                      █████ ▄███ ███ ███▄ █████     ',
\' █████░░▐█─┬┬┬┬┬┬┬─█▌░░█████                        |   yếu đuối với bản thân và đồng nghĩa với  |                      █████ ████ ███ ████ █████     ',
\' ████▌░░░▀┬┼┼┼┼┼┼┼┬▀░░░▐████                        |    người thương ta sẽ chịu thiệt thòi."    |                      █████ ████▄▄▄▄▄████ █████     ',
\' █████▄░░░└┴┴┴┴┴┴┴┘░░░▄█████                        |                                            |                       ▀███ █████████████ ███▀      ',
\' ███████▄░░░░░░░░░░░▄███████                        | -- Nguyễn Phước Duy Khoa                   |                         ▀█ ███ ▄▄▄▄▄ ███ █▀        ',
\' ██████████▄▄▄▄▄▄▄██████████                        +--------------------------------------------+                            ▀█▌▐█████▌▐█▀           ',
\ ]

let g:startify_custom_header = startify#center(s:header)

let s:footer=[
\'',
\'⣿⣿⣷⡁⢆⠈⠕⢕⢂⢕⢂⢕⢂⢔⢂⢕⢄⠂⣂⠂⠆⢂⢕⢂⢕⢂⢕⢂⢕⢂              ⢰⣧⣼⣯⠄⣸⣠⣶⣶⣦⣾⠄⠄⠄⠄⡀⠄⢀⣿⣿⠄⠄⠄⢸⡇⠄⠄          ⣿⢸⣿⣿⣿⣿⣿⢹⣿⣿⣿⣿⣿⢿⣿⡇⡇⣿⣿⡇⢹⣿⣿⣿⣿⣿⣿⠄⢸⣿',
\'⣿⣿⣿⡷⠊⡢⡹⣦⡑⢂⢕⢂⢕⢂⢕⢂⠕⠔⠌⠝⠛⠶⠶⢶⣦⣄⢂⢕⢂⢕              ⣾⣿⠿⠿⠶⠿⢿⣿⣿⣿⣿⣦⣤⣄⢀⡅⢠⣾⣛⡉⠄⠄⠄⠸⢀⣿⠄          ⡟⢸⣿⣿⣭⣭⡭⣼⣶⣿⣿⣿⣿⢸⣧⣇⠇⢸⣿⣿⠈⣿⣿⣿⣿⣿⣿⡆⠘⣿',
\'⣿⣿⠏⣠⣾⣦⡐⢌⢿⣷⣦⣅⡑⠕⠡⠐⢿⠿⣛⠟⠛⠛⠛⠛⠡⢷⡈⢂⢕⢂             ⢀⡋⣡⣴⣶⣶⡀⠄⠄⠙⢿⣿⣿⣿⣿⣿⣴⣿⣿⣿⢃⣤⣄⣀⣥⣿⣿⠄          ⡇⢸⣿⣿⣿⣿⡇⣻⡿⣿⣿⡟⣿⢸⣿⣿⠇⡆⣝⠿⡌⣸⣿⣿⣿⣿⣿⡇⠄⣿',
\'⠟⣡⣾⣿⣿⣿⣿⣦⣑⠝⢿⣿⣿⣿⣿⣿⡵⢁⣤⣶⣶⣿⢿⢿⢿⡟⢻⣤⢑⢂             ⢸⣇⠻⣿⣿⣿⣧⣀⢀⣠⡌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⠄          ⢣⢾⣾⣷⣾⣽⣻⣿⣇⣿⣿⣧⣿⢸⣿⣿⡆⢸⣹⣿⣆⢥⢛⡿⣿⣿⣿⡇⠄⣿',
\'⣾⣿⣿⡿⢟⣛⣻⣿⣿⣿⣦⣬⣙⣻⣿⣿⣷⣿⣿⢟⢝⢕⢕⢕⢕⢽⣿⣿⣷⣔            ⢀⢸⣿⣷⣤⣤⣤⣬⣙⣛⢿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡍⠄⠄⢀⣤⣄⠉⠋⣰          ⣛⡓⣉⠉⠙⠻⢿⣿⣿⣟⣻⠿⣹⡏⣿⣿⣧⢸⣧⣿⣿⣨⡟⣿⣿⣿⣿⡇⠄⣿',
\'⣿⣿⠵⠚⠉⢀⣀⣀⣈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣗⢕⢕⢕⢕⢕⢕⣽⣿⣿⣿⣿            ⣼⣖⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⢇⣿⣿⡷⠶⠶⢿⣿⣿⠇⢀⣤          ⠸⣷⣹⣿⠄⠄⠄⠄⠘⢿⣿⣿⣯⣳⣿⣭⣽⢼⣿⣜⣿⣇⣷⡹⣿⣿⣿⠁⢰⣿',
\'⢷⣂⣠⣴⣾⡿⡿⡻⡻⣿⣿⣴⣿⣿⣿⣿⣿⣿⣷⣵⣵⣵⣷⣿⣿⣿⣿⣿⣿⡿           ⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣷⣶⣥⣴⣿⡗          ⠸⢻⣷⣿⡄⢈⠿⠇⢸⣿⣿⣿⣿⣿⣿⣟⠛⠲⢯⣿⣒⡾⣼⣷⡹⣿⣿⠄⣼⣿',
\'⢌⠻⣿⡿⡫⡪⡪⡪⡪⣺⣿⣿⣿⣿⣿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃           ⢀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟           ⡄⢸⣿⣿⣷⣬⣽⣯⣾⣿⣿⣿⣿⣿⣿⣿⣿⡀⠄⢀⠉⠙⠛⠛⠳⠽⠿⢠⣿⣿',
\'⠣⡁⠹⡪⡪⡪⡪⣪⣾⣿⣿⣿⣿⠋⠐⢉⢍⢄⢌⠻⣿⣿⣿⣿⣿⣿⣿⣿⠏⠈           ⢸⣿⣦⣌⣛⣻⣿⣿⣧⠙⠛⠛⡭⠅⠒⠦⠭⣭⡻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃           ⡇⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⢄⣹⡿⠃⠄⠄⣰⠎⡈⣾⣿⣿',
\'⡣⡘⢄⠙⣾⣾⣾⣿⣿⣿⣿⣿⣿⡀⢐⢕⢕⢕⢕⢕⡘⣿⣿⣿⣿⣿⣿⠏⠠⠈           ⠘⣿⣿⣿⣿⣿⣿⣿⣿⡆⠄⠄⠄⠄⠄⠄⠄⠄⠹⠈⢋⣽⣿⣿⣿⣿⣵⣾⠃           ⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣭⣽⣖⣄⣴⣯⣾⢷⣿⣿⣿',
\'⠌⢊⢂⢣⠹⣿⣿⣿⣿⣿⣿⣿⣿⣧⢐⢕⢕⢕⢕⢕⢅⣿⣿⣿⣿⡿⢋⢜⠠⠈            ⠘⣿⣿⣿⣿⣿⣿⣿⣿⠄⣴⣿⣶⣄⠄⣴⣶⠄⢀⣾⣿⣿⣿⣿⣿⣿⠃            ⣧⠸⣿⣿⣿⣿⣿⣿⠯⠊⠙⢻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⣾⣿⣿⣿',
\'⠄⠁⠕⢝⡢⠈⠻⣿⣿⣿⣿⣿⣿⣿⣷⣕⣑⣑⣑⣵⣿⣿⣿⡿⢋⢔⢕⣿⠠⠈             ⠈⠻⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⠄⣿⣿⡀⣾⣿⣿⣿⣿⣛⠛⠁             ⣿⣦⠹⣿⣿⣿⣿⣿⠄⢀⣴⢾⣼⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣾⣿⣿⣿⣿',
\'⠨⡂⡀⢑⢕⡅⠂⠄⠉⠛⠻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢋⢔⢕⢕⣿⣿⠠⠈               ⠈⠛⢿⣿⣿⣿⠁⠞⢿⣿⣿⡄⢿⣿⡇⣸⣿⣿⠿⠛⠁               ⣿⣿⣇⢽⣿⣿⣿⡏⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⡿⣿⣛⣻⠿⣟⣼⣿⣿⣿⣿⢃',
\'⠄⠪⣂⠁⢕⠆⠄⠂⠄⠁⡀⠂⡀⠄⢈⠉⢍⢛⢛⢛⢋⢔⢕⢕⢕⣽⣿⣿⠠⠈                  ⠉⠻⣿⣿⣾⣦⡙⠻⣷⣾⣿⠃⠿⠋⠁                  ⣿⣿⣿⡎⣷⣽⠻⣇⣿⣿⣿⡿⣟⣵⣿⣟⣽⣾⣿⣿⣿⣿⢯⣾⣿⣿⣿⠟⠱⡟',
\'',
\]

let g:startify_custom_footer = startify#center(s:footer)

