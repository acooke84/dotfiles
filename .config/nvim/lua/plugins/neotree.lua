return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "NeoTree",
  keys = {
    { "<leader>fe", "<cmd>Neotree toggle<cr>", desc = "File Explorer" }
  },
  config = function()
    require("neo-tree").setup()
  end
}
