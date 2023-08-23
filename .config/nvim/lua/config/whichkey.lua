local M = {}

M.setup = function()
  local wk = require("which-key")
  wk.setup({
    window = {
      border = "single",
      position = "bottom",
    }
  })
  
  local opts = {
    mode = "n",
    prefix = "<leader>",
    silent = true,
    noremap = true
  }

  local keymap = {
    ["w"] = { "<cmd>update!<cr>", "Save" },
    ["q"] = { "<cmd>lua require('utils').quit()<cr>", "Quit" },
    f = {
      name = "Files",
      f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find" },
      e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    },
    z = {
      name = "Packer",
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      C = { "<cmd>PackerClean<cr>", "Clean" }
    }
  }

  wk.register(keymap, opts)
end

return M
