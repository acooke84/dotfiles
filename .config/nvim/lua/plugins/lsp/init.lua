return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "hrsh7th/cmp-nvim-lsp", cond = function() return require("utils").has("nvim-cmp") end },
    },
    opts = function()
      local server_configs = require("utils").lsp_server_configs()
      return {
        diagnostics = {
          underline = true,
          update_in_insert = false,
          severity_sort = true,
        },
        inlay_hints = { enabled = false, },
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                documentationFormat = { "markdown", "plaintext" },
                snippetSupport = true,
                preselectSupport = true,
                insertReplaceSupport = true,
                labelDetailsSupport = true,
                deprecatedSupport = true,
                commitCharactersSupport = true,
                tagSupport = { valueSet = { 1 } },
                resolveSupport = {
                  properties = {
                    "documentation",
                    "detail",
                    "additionalTextEdits",
                  },
                },
              }
            }
          }
        },
        autoformat = false,
        format_notify = true,
        servers = server_configs,
      }
    end,
    config = function(_, opts)
      local util = require("utils")
      if util.has("neoconf.nvim") then
        local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
        require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
      end

      util.on_attach(function(client, buffer)
        require("plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      local register_capability = vim.lsp.handlers["client/registerCapability"]
      vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client_id = ctx.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local buffer = vim.api.nvim_get_current_buf()
        require("plugins.lsp.keymaps").on_attach(client, buffer)
        return ret
      end

      for name, icon in pairs(require("config.icons").diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
      if opts.inlay_hints.enabled and inlay_hint then
        util.on_attach(function(client, buffer)
          if client.supports_method("textDocument/inlayHint") then
            inlay_hint(buffer, true)
          end
        end)
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup_server(server)
        local server_config = vim.tbl_deep_extend("force", { capabilities = vim.deepcopy(capabilities), }, opts.servers[server] or {})
        require("lspconfig")[server].setup(server_config)
      end

      local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
      if mason_lspconfig_ok then
        mason_lspconfig.setup({
          ensure_installed = vim.tbl_keys(opts.servers),
          automatic_installation = true,
          handlers = { setup_server }
        })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = function()
      local server_configs = require("utils").lsp_server_configs()
      return {
        ensure_installed = vim.tbl_keys(server_configs),
        automatic_installation = true,
      }
    end,
    config = function(_, opts)
      require("mason").setup(opts)
    end
  }
}
