local M = {}

local lspkind = require('lspkind')
local source_mapping = {
  nvim_lsp = '[LSP]',
  treesitter = '[Tree]',
  buffer = '[Buffer]',
  luasnip = '[Snip]',
  path = '[Path]',
}

M.setup = function()
  local status_ok, cmp = pcall(require, 'cmp')
  if not status_ok then
    return
  end

  cmp.setup {
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end
    },
    window = {
      documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
      },
    },
    mapping = {
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp', max_item_count = 15 },
      { name = 'treesitter', max_item_count = 5 },
      { name = 'luasnip', max_item_count = 5 },
    },
    formatting = {
      format = lspkind.cmp_format {
        mode = 'symbol_text',
        maxwidth = 40,
        before = function(entry, vim_item)
          vim_item.kind = lspkind.presets.default[vim_item.kind]

          local menu = source_mapping[entry.source.name]
          vim_item.menu = menu
          return vim_item
        end,
      },
    },
  }
end

return M
