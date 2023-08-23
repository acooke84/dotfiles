return {
  "folke/which-key.lua",
  opts = {
    setup = {
    },
    mappings = {
      {
        mapping = {
          ["w"] = { "<cmd>update!<cr>", "Save" },
          q = {
            name = "Quit",
            q = { "<cmd> lua require('utils').quit()", "Quit" },
            t = { "<cmd>tabclose<cr>", "Close Tab" },
          }
        },
        options = {
          mode = "n",
          prefix = "<leader>",
        }
      }
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts.setup)
    for _, mapping in ipairs(opts.mappings) do
      wk.register(mapping.mapping, mapping.options)
    end
  end,
}
