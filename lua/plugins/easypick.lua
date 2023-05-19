local easypick = require("easypick")
local M = {}
local base_branch = "master"
local cmd = vim.cmd

M.setup = function()
  easypick.setup({
    pickers = {
      {
        name = "ls",
        command = "ls",
        previewer = easypick.previewers.default()
      },
      {
        name = "changed_files",
        command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
        previewer = easypick.previewers.branch_diff({base_branch = base_branch})
      },
      {
        name = "conflicts",
        command = "git diff --name-only --diff-filter=U --relative",
        previewer = easypick.previewers.file_diff()
      },
    }
  })
end

M.mapping = function()
  cmd('nnoremap <leader>gf :Easypick changed_files<cr>')
  cmd('nnoremap <leader>gh :Easypick conflicts<cr>')
end
return M
