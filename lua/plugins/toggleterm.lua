local M = {}
local toggleterm = require('toggleterm')

M.setup = function()
  toggleterm.setup {
    open_mapping = [[<C-t>]],
    direction = 'float',
    float_opts = {
      border = 'double',
      persist_size = true,
      width = 150,
      height = 50,
    },
  }
  M.mapping()
end

M.mapping = function()
end

return M
