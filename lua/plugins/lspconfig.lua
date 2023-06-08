local M = {}
local lspconfig = require('lspconfig')

M.setup = function()
  vim.diagnostic.config({
    float = {
      source = 'always',
      border = 'rounded',
      focus = false,
    },
    severity_sort = true,
    virtual_text = false,
  })
  vim.cmd('autocmd CursorHold * lua vim.diagnostic.open_float()')

  lspconfig.tsserver.setup({
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      M.attach(client, bufnr)
    end,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  })
  lspconfig.eslint.setup({
    on_attach = function(client, bufnr)
      vim.cmd([[
      augroup LspEslint
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> EslintFixAll
      augroup END
      ]])
      -- M.attach(client, bufnr)
    end,
    settings = {
      codeActionOnSave = {
        enable = true,
        mode = "all"
      },
      format = true,
    },
  })
  lspconfig.stylelint_lsp.setup({
    on_attach = function(client, bufnr)
      vim.cmd([[
      augroup LspStylelint
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
      augroup END
      ]])
      M.attach(client, bufnr)
    end,
    settings = {
      stylelintplus = {
        autoFixOnFormat = true,
        autoFixOnSave = true,
      },
    },
  })
end

return M
