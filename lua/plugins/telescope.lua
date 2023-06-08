local M = {}
local telescope = require("telescope")
local keymap = vim.keymap.set
local opts = { silent = true }

M.setup = function()
  local actions = require('telescope.actions')
  local fb_actions = require("telescope").extensions.file_browser.actions
  local previewers = require('telescope.previewers')
  local preview_maker = function (filepath, bufnr, opts)
    local bad_files = function (filepath)
      local _bad = { 'metadata/.*%.json', 'html2pdf.bundle.min' } -- Put all filetypes that slow you down in this array
      for _, v in ipairs(_bad) do
        if filepath:match(v) then
          return false
        end
      end
      return true
    end

    opts = opts or {}
    if opts.use_ft_detect == nil then opts.use_ft_detect = true end
    opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
    previewers.buffer_previewer_maker(filepath, bufnr, opts)
  end

  telescope.setup {
    defaults = {
      layout_strategy = 'horizontal',
      layout_conig = {
        width = 0.8,
        height = 0.8,
      },
      borderchars = {
        "─", "│", "─", "│", "╭", "╮", "╯", "╰"
      },
      vimgrep_arguments = {
        'rg',
        '-FHLSn.',
        '--color=never',
        '--no-heading',
        '--line-number',
        '--column', 
        '--sort-files',
        '--trim',
        '--no-ignore',
        '--ignore-file',
        os.getenv("HOME") .. '/.config/rg/.rgignore',
      },
      file_ignore_patterns = {
        '.git/',
      },
      buffer_previewer_maker = preview_maker,
      preview = {
        mime_hook = function(filepath, bufnr, opts)
          local split_path = vim.split(filepath:lower(), '.', { plain = true })
          local ext = split_path[#split_path]

          if vim.tbl_contains({ 'png', 'jpg', 'jpeg' }, ext) then
            local term = vim.api.nvim_open_term(bufnr, {})
            local function send_output(_, data, _)
              for _, d in ipairs(data) do
                vim.api.nvim_chan_send(term, d .. '\r\n')
              end
            end

            vim.fn.jobstart(
              { 'catimg', '-w 150', filepath },
              { on_stdout = send_output, stdout_buffered = true }
            )
          else
            require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
          end
        end
      },
      mappings = {
        i = {
          ["<esc>"] = actions.close,
        },
      },
    },
    pickers = {
      find_files = {
        find_command = {
         'fd',
         '-FHIL',
          '--type=f',
          '--color=never',
          '--strip-cwd-prefix', -- Remove ./ prefix in find_files
          '--no-ignore',
          '--ignore-file',
          os.getenv("HOME") .. '/.config/fd/.fdignore',
        },
      },
    },
    extensions = {
      project = {
        hidden_files = true,
        theme = "dropdown",
      },
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
      file_browser = {
        mappings = {
          ['i'] = {
            ['<C-e>'] = fb_actions.create,
            ['<C-r>'] = fb_actions.rename,
            ['<C-p>'] = fb_actions.move,
            ['<C-y>'] = fb_actions.copy,
            ['<C-d>'] = fb_actions.remove,
            ['<C-w>'] = fb_actions.goto_cwd,
          },
        },
        hidden = true,
        respect_gitignore = false,
        grouped = true,
        select_buffer = true,
        display_stat = false,
      }
    },
  }

  telescope.load_extension('fzf')
  telescope.load_extension('file_browser')
  telescope.load_extension('project')

  M.mapping()

end

M.mapping = function ()
  keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
  keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
  keymap('n', '<leader>bf', '<cmd>Telescope buffers<cr>', opts)
  keymap('n', '<leader>fb', ':Telescope file_browser path=%:p:h<cr>', opts)
  keymap('n', '<leader>l', '<cmd>lua require("telescope").extensions.project.project{ display_type="full" }<CR>', opts)
end

return M
