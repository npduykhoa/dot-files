local M = {}

M.setup = function()
  M.mapping()
end

M.mapping = function()
  ---Any jump---
  --Normal mode: Jump to definition under cursor
  vim.cmd('nnoremap <leader>j :AnyJump<CR>')
  --Visual mode: jump to selected text in visual mode
  vim.cmd('xnoremap <leader>j :AnyJumpVisual<CR>')
  ----Normal mode: open previous opened file (after jump)
  vim.cmd('nnoremap <leader>. :AnyJumpBack<CR>')
  ----Normal mode: open last closed search window again
  vim.cmd('nnoremap <leader>al :AnyJumpLastResults<CR>')
end

return M
