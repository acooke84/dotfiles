local M = {}

local servers = {
  jsonls = {},
  pyright = {},
  sumneko_lua = {},
  tsserver = {},
  clangd = {},
}

M.on_attach = function(client, bufnr) 
  local capabilities = client.server_capabilities

  if capabilities.completionProvider then
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
  end

  if capabilities.documentFormattingProvider then
    vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
  end

  if capabilities.definitionProvider then
    vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = capabilities

local opts = {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

require('config.lsp.handlers').setup()

M.setup = function()
  require('config.lsp.installer').setup(servers, opts)
end

return M
