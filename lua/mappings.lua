local cmd = vim.cmd
local g = vim.g
local keyset = vim.keymap.set

g.mapleader=' '

cmd('nmap <leader>w :w<CR>')
cmd('nmap <leader>e :q!<CR>')
cmd('nmap <leader>k :noa w<CR>')

---Navigation Panel---
cmd('nnoremap <C-h> <C-w>h')
cmd('nnoremap <C-j> <C-w>j')
cmd('nnoremap <C-k> <C-w>k')
cmd('nnoremap <C-l> <C-w>l')
cmd('nnoremap <C-v> <C-w>v')
cmd('nnoremap <C-s> <C-w>s')

---Resize Panel---
cmd('nnoremap <leader>u :vertical resize +10<CR>')
cmd('nnoremap <leader>d :vertical resize -10<CR>')

---Visual mode---
cmd('vmap < <gv')
cmd('vmap > >gv')
cmd("vmap J :m '>+1<CR>gv=gvzz")
cmd("vmap K :m '<-2<CR>gv=gvzz")

---Clear all buffers---
vim.keymap.set("n", "<leader>bo", "<cmd>%bd|e#<cr>", {desc="Close all buffers but the current one"})

---Toggle highlight---
vim.keymap.set("n", '<leader>r', ':if exists("g:syntax_on")<Bar>syntax off<Bar>else<Bar>syntax on<Bar>endif<CR>|:TSToggle highlight<CR>|:TSToggle rainbow<CR>')

---Ignore highlight text---
cmd('nnoremap <silent> <leader>h :noh<CR>')

---Format JSON---
cmd('vnoremap jq :!jq -S .<cr>')

---Auto Complete & Import---
-- cmd('inoremap <silent><expr> <C-space> coc#refresh()')
-- cmd([[inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : '\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>']])


vim.opt.list = true
--vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

--nmap <leader>r :e!<CR>
--au ColorScheme * highlight Visual guibg=#71052e

---Create new file
--v.nmap({'silent'}, '<leader>n', ':enew<CR>')

--vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

---GitBlame---
g.gitblame_enabled = 0
cmd('nmap <leader>gb :GitBlameToggle<CR>')

---Auto Complete & Import---
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})


--Search keyword and replace
cmd([[
  vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
  omap s :normal vs<CR>
]])
