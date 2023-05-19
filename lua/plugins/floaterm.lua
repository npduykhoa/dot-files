local M = {}
local cmd = vim.cmd
local g = vim.g

M.setup = function()
  M.mapping()
end

M.mapping = function()
  g.floaterm_keymap_toggle = '<leader>ft'
  g.floaterm_keymap_new = '<leader>fo'
  g.floaterm_keymap_prev = '<leader>fp'
  g.floaterm_keymap_next = '<leader>fn'
  g.floaterm_keymap_kill = '<leader>fk'
  g.floaterm_gitcommit='floaterm'
  g.floaterm_width=0.8
  g.floaterm_height=0.8
  g.floaterm_wintitle=0
  g.floaterm_autoclose=1
  g.floaterm_completeoptPreview=1
end

return M
