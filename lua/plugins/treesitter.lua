local M = {}
local treesitter = require("nvim-treesitter.configs")

M.setup = function()
  treesitter.setup {
    highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = true,
      -- disable = { "javascript" }
    },
    autotag = {
      enable = true,
    },
    rainbow = {
      enable = true,
      extended_mode = true,
    },
    -- ensure_installed = {
    --   'css', 'html', 'javascript',
    --   'lua', 'scss', 'tsx', 'typescript', 'vim',
    -- },
    context_commentstring = {
      enable = true
    },
    refactor = {
      highlight_definitions = {
        enable = true,
        clear_on_cursor_move = true,
      },
      highlight_current_scope = { enable = true },
    },
  }
end

return M
