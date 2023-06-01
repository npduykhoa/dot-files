local M = {}
local tokyonight = require("tokyonight")
local g = vim.g

M.setup = function()
  tokyonight.setup({
    transparent = true,
    on_colors = function(c)
      c.border = c.border_highlight
    end,
    on_highlights = function(hl, c)
      hl.rainbowcol1 = { fg = c.red1 }
      hl.rainbowcol2 = { fg = c.orange }
      hl.rainbowcol3 = { fg = '#e0d60d' }
      hl.rainbowcol4 = { fg = c.teal }
      hl.rainbowcol5 = { fg = '#326bc7' }
      hl.rainbowcol6 = { fg = c.blue1 }
      hl.rainbowcol7 = { fg = c.purple }

      hl['@variable'] = hl['@property']
      hl['@keyword.operator'] = hl['@keyword']
      hl['@constant.builtin'] = hl['@constant']
    end,
  })

  g.lightline = {
    colorscheme = 'tokyonight'
  }

  local transparents = {
    "Normal",
    "NormalNC",
    "Comment",
    "Constant",
    "Special",
    "Identifier",
    "Statement",
    "PreProc",
    "Type",
    "Underlined",
    "Todo",
    "String",
    "Function",
    "Conditional",
    "Repeat",
    "Operator",
    "Structure",
    "LineNr",
    "NonText",
    "SignColumn",
    "CursorLineNr",
    "EndOfBuffer",

    'NormalFloat',
    'FloatBorder',
    'TelescopeNormal',
    'TelescopeBorder',
    'TelescopeMultiSelection',
  }

  for _, part in pairs(transparents) do
    vim.cmd('au VimEnter * highlight ' .. part .. ' ctermbg=NONE guibg=NONE')
  end

end

vim.cmd("colorscheme tokyonight-storm")

return M
