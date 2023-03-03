call plug#begin(expand('~/.config/nvim/plugged'))

"************************************************
"(                Vim Plugins                   )
"************************************************

"---Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' | Plug 'windwp/nvim-ts-autotag'

" On-demand loading
Plug 'nvim-telescope/telescope-file-browser.nvim'

" Greeting Screen
Plug 'mhinz/vim-startify'

" Fonts & Themes
" Plug 'morhetz/gruvbox'
"Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}
Plug 'nvim-lualine/lualine.nvim'

" Highlight Tokens
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} | Plug 'nvim-treesitter/nvim-treesitter-refactor' | Plug 'p00f/nvim-ts-rainbow' | Plug 'norcalli/nvim-colorizer.lua'

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

" Comment line
Plug 'JoosepAlviste/nvim-ts-context-commentstring' | Plug 'tpope/vim-commentary'

"Plug 'edluffy/specs.nvim'

"Plug 'eandrju/cellular-automaton.nvim'


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

set fillchars+=vert:\|
set backspace=indent,eol,start
set noshowmode
set cmdheight=0
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
set updatetime=100
set autoread
set signcolumn=number
set hlsearch
set incsearch
set ignorecase
set smartcase
set termguicolors
"--vim faster configs
" set lazyredraw
" set ttyfast
" set mmp=500000
" set modeline
" set re=2
" set synmaxcol=128
" syntax sync minlines=256
syntax enable

"---Transparent background
au VimEnter * highlight Normal ctermbg=NONE guibg=NONE

"autocmd BufReadPost * echo strftime("%c")
"---Auto open Nerdtree and Startify when start Vim
"autocmd VimEnter * if !argc() | Startify | wincmd o | NERDTree | wincmd w | endif

"---Search keyword & replace all in file---
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

"---DiffView---
nmap dc :DiffviewClose<CR>
nmap do :DiffviewOpen<CR>
nmap dh :DiffviewFileHistory<CR>

"---Themes---
set background=dark
color gruvbox

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
nnoremap <silent> <leader>h :noh<CR>

"---Auto Complete & Import---
inoremap <silent><expr> <C-space> coc#refresh()
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
nnoremap <leader>fb :Telescope file_browser path=%:p:h<cr>
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

lua << EOF

--disable some builtin vim plugins
local g = vim.g
local cmd = vim.cmd

cmd('filetype on')
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}
for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

local easypick = require("easypick")
local base_branch = "master"
local actions = require('telescope.actions')
local fb_actions = require("telescope").extensions.file_browser.actions

local previewers = require('telescope.previewers')

local preview_maker = function (filepath, bufnr, opts)
  local bad_files = function (filepath)
    local _bad = { 'metadata/.*%.json', 'html2pdf.bundle.min' } -- Put all filetypes that slow you down in this array
    for _, v in ipairs(_bad) do
      if filepath:match(v) then
        return false
      end
    end
    return true
  end

  opts = opts or {}
  if opts.use_ft_detect == nil then opts.use_ft_detect = true end
  opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
  previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

easypick.setup({
  pickers = {
    {
      name = "ls",
      command = "ls",
      previewer = easypick.previewers.default()
    },
    {
      name = "changed_files",
      command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
      previewer = easypick.previewers.branch_diff({base_branch = base_branch})
    },
    {
      name = "conflicts",
      command = "git diff --name-only --diff-filter=U --relative",
      previewer = easypick.previewers.file_diff()
    },
  }
})

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {{ 'filename', path = 1 }},
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {},
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    use_languagetree = true,
    -- additional_vim_regex_highlighting = false,
  },
  autotag = {
    enable = true,
  },
  rainbow = {
    enable = true,
  },
  context_commentstring = {
    enable = true
  },
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true,
    },
    highlight_current_scope = { enable = true },
  },
}

require'telescope'.setup {
  defaults = {
    layout_strategy = 'horizontal',
    layout_conig = {
      width = 0.8,
      height = 0.8,
    },
    borderchars = {
      prompt = { " ", " ", " ", " ", "─", "─", " ", " " },
      results = { " "},
      preview = { " " },

      -- prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      -- results = { "─", " ", " ", "│", "╭", "╮", " ", " " },
      -- preview = { "─", "│", "─", " ", "╭", "╮", "╯", "╰" },

      -- "─", "│", "─", "│", "╭", "╮", "╯", "╰"
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
  extensions = {
    project = {
      hidden_files = true
    },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
    file_browser = {
      mappings = {
        ['i'] = {
          ['<C-e>'] = fb_actions.create,
          ['<C-r>'] = fb_actions.rename,
          ['<C-p>'] = fb_actions.move,
          ['<C-y>'] = fb_actions.copy,
          ['<C-d>'] = fb_actions.remove,
        },
      }
    }
  },
}

vim.keymap.set("n", "<leader>bo", "<cmd>%bd|e#<cr>", {desc="Close all buffers but the current one"})

-- Load the colorscheme
 vim.cmd[[colors tokyonight-storm]]

require('telescope').load_extension('file_browser')

--vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")
vim.keymap.set("n", '<leader><leader>', ':if exists("g:syntax_on")<Bar>syntax off<Bar>else<Bar>syntax on<Bar>endif<CR>|:TSToggle highlight<CR>|:TSToggle rainbow<CR>')

vim.opt.list = true
--vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

-- vim.opt.termguicolors = true

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}

require 'colorizer'.setup({
  '*';
  scss = { rgb_fn = true; };
  html = { names = false; };
  }, { mode = 'foreground' })

EOF

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
let g:gitblame_enabled = 0
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
\' ██▀─┘░░░░░░░▐█▌░░░░░░░└─▀██                                         ⇆ ◁ ㅤ❚❚ ↻                                         ███        ███        ███     ',
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
  \ 'coc-emmet',
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

