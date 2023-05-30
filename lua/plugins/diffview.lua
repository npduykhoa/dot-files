local M = {}
local cmd = vim.cmd

M.setup = function()
  M.mapping()
end

M.mapping = function()
  cmd('nmap dc :DiffviewClose<CR>')
  cmd('nmap do :DiffviewOpen<CR>')
  cmd('nmap dh :DiffviewFileHistory %<CR>')
end

return M
