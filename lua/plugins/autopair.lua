local M = {}

M.setup = function()
  local npairs = require('nvim-autopairs')
  local Rule   = require('nvim-autopairs.rule')
  npairs.setup {
    check_ts = true,
    map_cr = false, --set false because conflict <CR> with coc completion (https://superuser.com/questions/1734914)
    ignored_next_char = "[%w%.]"
  }
  npairs.add_rules {
    Rule(' ', ' ')
      :with_pair(function (opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ '()', '[]', '{}' }, pair)
      end),
    Rule('( ', ' )')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%)') ~= nil
      end)
      :use_key(')'),
    Rule('{ ', ' }')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%}') ~= nil
      end)
      :use_key('}'),
    Rule('[ ', ' ]')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%]') ~= nil
      end)
      :use_key(']')
  }
end

return M
