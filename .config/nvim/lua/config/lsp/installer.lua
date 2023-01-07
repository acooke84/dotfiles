local M = {}

M.setup = function(servers, server_options)
  local lspconfig = require('lspconfig')
  local icons = require('utils.icons')

  require('mason').setup {
    ui = {
      icons = {
        package_installed = icons.lsp.server_installed,
        package_pending = icons.lsp.server_pending,
        package_uninstalled = icons.lsp.server_uninstalled,
      },
    },
  }

  require('mason-lspconfig').setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = false,
  }

  --for server_name, _ in pairs(servers) do
  --  local opts = vim.tbl_deep_extend('force', server_options, servers[server_name] or {})
  --  lspconfig[server_name].setup(opts)
  --end

  require('mason-lspconfig').setup_handlers {
    function(server_name)
      local opts = vim.tbl_deep_extend('force', server_options, servers[server_name] or {})
      lspconfig[server_name].setup(opts)
    end
  }
  
end

return M
