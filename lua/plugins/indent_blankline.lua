local M = {}
-- local indent = require("indent_blankline")
local indent = require("hlchunk")
M.setup = function()
  indent.setup {
  --   space_char_blankline = " ",
  --   show_current_context = true,
  --   show_current_context_start = true,
    chunk = {
      enable = true,
      use_treesitter = true,
      chars = {
          horizontal_line = "⌲",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = "⌲",
      },
      style = {
          { fg = "#00ffff" },
      },
    },

    indent = {
      enable = false,
    },

    line_num = {
      enable = false,
    },

    blank = {
      enable = false,
    },
  }
end

return M
