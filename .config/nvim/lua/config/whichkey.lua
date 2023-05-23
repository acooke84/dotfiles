local M = {}

function M.setup()
  local whichkey = require("which-key")
  
  local conf = {
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "  ", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    window = {
      border = "single",
      position = "bottom",
    },
    layout = {
      spacing = 6,
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
    triggers_blacklist = {
      i = { "j", "k" },
      v = { "j", "k" },
    }
  }

  local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  }

  local mappings = {
    ["w"] = { "<cmd>update!<cr>", "Save" },
    ["q"] = { "<cmd>q!<cr>", "Quit" },
    ["|"] = { "<cmd>vsplit<cr>", "Vertical Split" },
    ["-"] = { "<cmd>split<cr>", "Horizontal Split" },

    b = {
      name = "Buffer",
      d = { "<cmd>bd<cr>", "Close current buffer" },
      a = { "<cmd>%bd|e#|bd#<cr>", "Delete all buffers" },
      l = { "<cmd>ls<cr>", "List all buffers" },
      n = { "<cmd>bn<cr>", "Next buffer" },
      p = { "<cmd>bp<cr>", "Previous buffer" },
      f = { "<cmd>bd!<cr>", "Force delete current buffer" },
      b = { "<cmd>BufferLinePick<cr>", "Pick a buffer" },
    },

    z = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      p = { "<cmd>PackerProfile<cr>", "Profile" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    f = {
      name = "File",
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
      c = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search current buffer" },
      g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
      h = { "<cmd>Telescope help_tags<cr>", "Help" },
      f = { "<cmd>Telescope find_files<cr>", "Find Files" },
      n = { "<cmd>ene <BAR> startinsert <cr>", "New File" },
      r = { "<cmd>lua require'telescope'.extensions.file_browser.file_browser()<cr>", "File Browser" },
      t = { "<cmd>Telescope<cr>", "Telescope" },
      e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    },

    t = {
      name = "Tabs",
      a = { "<cmd>tabnew<cr>", "Add Tab" },
      n = { "<cmd>tabnext<cr>", "Tab Next" },
      p = { "<cmd>tabprev<cr>", "Tab Previous" }
    },
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M
