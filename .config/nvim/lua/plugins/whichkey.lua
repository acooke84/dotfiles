return {
  "folke/which-key.nvim",
  lazy = false,
  opts = {
    setup = {
      show_help = true,
      key_labels = { ["<leader>"] = "SPC" },
      triggers = "auto",
      window = {
        border = "single",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 1, 1, 1, 1 },
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
      },
    },
    mapping_pairs = {
      {
        mappings = {
          ["w"] = { "<cmd>update!<cr>", "Save" },
          ["-"] = { "<cmd>split<cr>", "Split Horizontal" },
          ["|"] = { "<cmd>vsplit<cr>", "Split Vertical" },
          q = {
            name = "Quit/Session",
            q = { function() require("utils").quit(false) end, "Quit" },
            s = { function() require("utils").quit(true) end, "Quit Session" },
            t = { "<cmd>tabclose<cr>", "Close Tab" },
          },
          f = {
            name = "Files",
            f = { "<cmd>Telescope find_files<cr>", "Find" },
          },
          t = {
            name = "Tabs",
            t = { "<cmd>tabnew<cr>", "New Tab" },
            n = { "<cmd>tabnext<cr>", "Next Tab" },
            p = { "<cmd>tabprev<cr>", "Previous Tab" },
          },
          l = {
            name = "LSP",
          },
          m = {
            name = "Motion",
          }
        },
        options = { mode = "n", prefix = "<leader>", buffer = nil, silent = true, noremap = true, nowait = false }
      },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts.setup)
    for _, mapping in ipairs(opts.mapping_pairs) do
      wk.register(mapping.mappings, mapping.options)
    end
  end
}
