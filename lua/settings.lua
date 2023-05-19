local g = vim.g
local cmd = vim.cmd

cmd('syntax enable')
cmd('set mouse+=a')
cmd('set backspace=indent,eol,start')
cmd('set noshowmode')
cmd('set cmdheight=0')
cmd('set clipboard+=unnamedplus')
cmd('set whichwrap+=<,>,h,l,[,]')
cmd('set nobackup')
cmd('set nowritebackup')
--Encoding
cmd('set encoding=utf-8')

cmd('set number')
cmd('set relativenumber')
cmd('set cursorline')
cmd('set tabstop=2')
cmd('set shiftwidth=2')
cmd('set expandtab')
--Enable hidden buffers
cmd('set hidden')
--Status bar
cmd('set laststatus=2')
cmd('set updatetime=300')
cmd('set autoread')
cmd('set signcolumn=number')

--Searching
cmd('set hlsearch')
cmd('set incsearch')
cmd('set ignorecase')
cmd('set smartcase')
--set termguicolors
--vim faster configs
cmd('set lazyredraw')
cmd('set ttyfast')
cmd('au TextYankPost * lua vim.highlight.on_yank {on_visual = false}')

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
