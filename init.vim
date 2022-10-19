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

" Fonts & Themes
Plug 'folke/tokyonight.nvim', { 'branch': 'main' } | Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes' | Plug 'ryanoasis/vim-devicons' | Plug 'kyazdani42/nvim-web-devicons' | Plug 'vwxyutarooo/nerdtree-devicons-syntax'

" Highlight Tokens
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} | Plug 'p00f/nvim-ts-rainbow'

" Popup
Plug 'voldikss/vim-floaterm' | Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'

" Git
Plug 'f-person/git-blame.nvim' | Plug 'tpope/vim-fugitive' | Plug 'airblade/vim-gitgutter', {'branch': 'master'} | Plug 'axkirillov/easypick.nvim'

" Diffview
Plug 'nvim-lua/plenary.nvim' | Plug 'sindrets/diffview.nvim'

" Coc vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Indent Line
Plug 'lukas-reineke/indent-blankline.nvim'

" Go to detail
Plug 'pechorin/any-jump.vim'

" Sound Keyboard
Plug 'skywind3000/vim-keysound'

call plug#end()

"***********************************************
"(                Basic Setup                  )
"***********************************************

let mapleader=' '

set mouse+=a

nmap <leader>w :w<CR>
nmap <leader>e :q!<CR>
nmap <leader>k :noa w<CR>
nmap <leader>r :e!<CR>

set clipboard+=unnamedplus
set whichwrap+=<,>,h,l,[,]
set encoding=utf-8
set number
set relativenumber
set cursorline
set tabstop=2
set shiftwidth=2
set expandtab
set hidden
set laststatus=2
set updatetime=250
set autoread
set lazyredraw
set ttyfast
set mmp=500000
"---Transparent background
au VimEnter * highlight Normal ctermbg=NONE guibg=NONE

"autocmd BufReadPost * echo strftime("%c")
"---Auto open Nerdtree and Startify when start Vim
autocmd VimEnter * if !argc() | Startify | wincmd o | NERDTree | wincmd w | endif

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
colorscheme tokyonight

"---Navigation Panel---
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-v> <C-w>v
nnoremap <C-s> <C-w>s

"---Resize Panel---
nnoremap <leader>u :vertical resize +10<CR>
nnoremap <leader>d :vertical resize -10<CR>

"---Visual mode---
vmap < <gv
vmap > >gv
vmap J :m '>+1<CR>gv=gvzz
vmap K :m '<-2<CR>gv=gvzz

"---Ignore highlight text---
nnoremap <silent> <Space><Space> :noh<CR>

"---Auto Complete & Import---
inoremap <silent><expr> <C-space> coc#refresh()
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<C-g>u\<TAB>"

"**********************************************
"(            Plugins Configuration           )
"**********************************************

"---Key Sound---
"let g:keysound_enable = 1
let g:keysound_theme = 'typewriter'
let g:keysound_py_version = 0
let g:keysound_volume = 1000

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>gf :Easypick changed_files<cr>
nnoremap <leader>gh :Easypick conflicts<cr>

"---FloatTerm---
let g:floaterm_keymap_toggle = '<leader>ft'
let g:floaterm_keymap_new = '<leader>fo'
let g:floaterm_keymap_prev = '<leader>fp'
let g:floaterm_keymap_next = '<leader>fn'
let g:floaterm_keymap_kill = '<leader>fk'
let g:floaterm_gitcommit='floaterm'
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1
let g:floaterm_completeoptPreview=1

"---Airline---
" :AirlineTheme simple
" https://github.com/vim-airline/vim-airline-themes/tree/master/autoload/airline/themes
let g:airline_theme='zenburn'
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

local easypick = require("easypick")
local base_branch = "master"
local actions = require('telescope.actions')

easypick.setup({
	pickers = {
		-- add your custom pickers here
		-- below you can find some examples of what those can look like

		-- list files inside current folder with default previewer
		{
			-- name for your custom picker, that can be invoked using :Easypick <name> (supports tab completion)
			name = "ls",
			-- the command to execute, output has to be a list of plain text entries
			command = "ls",
			-- specify your custom previwer, or use one of the easypick.previewers
			previewer = easypick.previewers.default()
		},

		-- diff current branch with base_branch and show files that changed with respective diffs in preview 
		{
			name = "changed_files",
			command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
			previewer = easypick.previewers.branch_diff({base_branch = base_branch})
		},
		
		-- list files that have conflicts with diffs in preview
		{
			name = "conflicts",
			command = "git diff --name-only --diff-filter=U --relative",
			previewer = easypick.previewers.file_diff()
		},
	}
})

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

require'telescope'.setup {
  defaults = {
    layout_strategy = 'horizontal',
    layout_conig = {
      width = 0.8,
      height = 0.8,
    },
    vimgrep_arguments = {
      'rg',
      '--hidden',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--fixed-strings',
      '--sort-files',
      '--trim',
    },
    file_ignore_patterns = {
      '.git/',
    },
    buffer_previewer_maker = preview_maker,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
  pickers = {
    find_files = {
      find_command = {
       'fd',
        '--type',
        'f',
        '--color=never',
        '--hidden',
        '--follow',
        '--strip-cwd-prefix', -- Remove ./ prefix in find_files
        '--no-ignore-vcs',
        '--exclude=node_modules',
        '--exclude=.git',
        '--exclude=dist*',
        '--exclude=build',
        '--exclude=.gradle',
        '--exclude=.next',
        '--exclude=to-be-copy/'
      },
    },
  },
  preview = {
    mime_hook = function(filepath, bufnr, opts)
      local split_path = vim.split(filepath:lower(), '.', { plain = true })
      local ext = split_path[#split_path]

      if vim.tbl_contains({ 'png', 'jpg', 'jpeg' }, ext) then
        local term = vim.api.nvim_open_term(bufnr, {})
        local function send_output(_, data, _)
          for _, d in ipairs(data) do
            vim.api.nvim_chan_send(term, d .. '\r\n')
          end
        end

        vim.fn.jobstart(
          { 'catimg', '-w 150', filepath },
          { on_stdout = send_output, stdout_buffered = true }
        )
      else
        require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
      end
    end
  },
}

vim.opt.list = true
--vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

require("indent_blankline").setup {
  char = "",
  char_highlight_list = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
  },
  space_char_highlight_list = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
  },
  show_trailing_blankline_indent = false,
}

EOF

"---NERDTree---
"autocmd VimEnter * NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeGitStatusUseNerdFonts = 1

"---NERDTree sync to current file activating
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()


"---Fuzzy Search & Ripgrep---
"nnoremap <silent> <C-S-p> :Files<CR>
"set wildmode=list:longest,list:full
"set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
"let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path '**/node_modules/**' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
"command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --fixed-strings ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
"nnoremap <silent> <leader>f :Rg<CR>

"---Any jump---
" Normal mode: Jump to definition under cursor
nnoremap <leader>j :AnyJump<CR>
" Visual mode: jump to selected text in visual mode
xnoremap <leader>j :AnyJumpVisual<CR>
" Normal mode: open previous opened file (after jump)
nnoremap <leader>ab :AnyJumpBack<CR>
" Normal mode: open last closed search window again
nnoremap <leader>al :AnyJumpLastResults<CR>

"---GitBlame---
nmap <leader>gb :GitBlameToggle<CR>

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

let g:coc_global_extensions = [
  \ 'coc-ultisnips',
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-yaml',
  \ 'coc-highlight',
  \ 'coc-eslint',
  \ 'coc-git',
  \ 'coc-prettier',
  \ ]

