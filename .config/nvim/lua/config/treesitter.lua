local M = {}

M.setup = function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = 'all',
    sync_install = false,
    highlight = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gnn',
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      }
    },
    indent = {
      enable = true,
      disable = {},
    },

    --textobjects
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        },
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V", -- linewise
          ["@class.outer"] = "<c-v>", -- blockwise
        },
      },
    }
  }
end

return M
