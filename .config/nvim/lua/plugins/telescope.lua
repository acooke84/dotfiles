return {
  "nvim-telescope/telescope.nvim",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
  },
  config = function()
    require("telescope").setup()
  end
}
