return {
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      require("notify").setup()
      vim.notify = require("notify")
    end
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    opts = {
      italic = {
        strings = false,
        comments = false,
        operators = false,
        folds = false,
      }
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      vim.cmd [[colorscheme gruvbox]]
    end,
  }
}
