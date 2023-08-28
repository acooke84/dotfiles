return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    config = function(_, opts)
      require("luasnip").setup(opts)
    end
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      local cmp = require("cmp")
      return {
        completion = {
          completeopt = "menu,menuone",
        },
        window = {
          documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
          },
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-u>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        },
        formatting = {
          format = function(_, item)
            local icons = require("config.icons")
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end
        },
        sources = {
          { name = "nvim_lsp", max_item_count = 8 },
          { name = "luasnip" },
          { name = "treesitter", max_item_count = 3 },
          { name = "buffer", max_item_count = 5 },
          { name = "nvim_lua", max_item_count = 3 },
          { name = "path", max_item_count = 3 },
        },
      }
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end
  }
}
