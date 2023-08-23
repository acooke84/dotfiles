local M = {}

M.setup = function()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local config = {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close
        },
      }
    }
  }

  telescope.setup(config)
end

return M
