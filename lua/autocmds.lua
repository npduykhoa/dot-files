local cmd = vim.cmd

function augroup(name, autocmds)
  cmd('augroup ' .. name)
  cmd('autocmd!')
  for _, autocmd in ipairs(autocmds) do
      cmd(autocmd)
  end
  cmd('augroup END')
end

cmd('au VimEnter * cd %:p:h')
cmd('au TextYankPost * lua vim.highlight.on_yank {on_visual = false}')

augroup('HighlightExtraWhitespace', {
  'highlight ExtraWhitespace guibg=#ffc777',
  'au VimEnter * match ExtraWhitespace /\\s\\+$/',
  'au InsertLeave * match ExtraWhitespace /\\s\\+$/',
  'au InsertEnter * match NONE /\\s\\+$/',
})

--autocmd BufReadPost * echo strftime("%c")
---Auto open Nerdtree and Startify when start Vim
--autocmd VimEnter * if !argc() | Startify | wincmd o | NERDTree | wincmd w | endif

--Transparent background
cmd('au ColorScheme * highlight Normal ctermbg=NONE guibg=NONE')


-- PATCH: in order to address the message:
-- vim.treesitter.query.get_query() is deprecated, use vim.treesitter.query.get() instead. :help deprecated
--   This feature will be removed in Nvim version 0.10
local orig_notify = vim.notify
local filter_notify = function(text, level, opts)
  -- more specific to this case
  if type(text) == "string" and (string.find(text, "get_query", 1, true) or string.find(text, "get_node_text", 1, true)) then
  -- for all deprecated and stack trace warnings
  -- if type(text) == "string" and (string.find(text, ":help deprecated", 1, true) or string.find(text, "stack trace", 1, true)) then
    return
  end
  orig_notify(text, level, opts)
end
vim.notify = filter_notify
