local M = {}
local treesitter = require("nvim-treesitter.configs")

M.setup = function()
  treesitter.setup {
    highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = true,
    },
    autotag = {
      enable = true,
    },
    rainbow = {
      enable = true,
      query = {
        javascript = 'rainbow-tags-react',
        tsx = 'rainbow-tags-react',
      },
    },
    context_commentstring = {
      enable = true
    },
  }
end

return M
