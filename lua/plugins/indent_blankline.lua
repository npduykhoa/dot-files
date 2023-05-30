local M = {}
local indent = require("indent_blankline")

M.setup = function()
  indent.setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
  }
end

return M
