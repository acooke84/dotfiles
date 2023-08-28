return {
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    keys = {
      { "gza", mode = { "n", "v" }, desc = "Add surrounding" },
      { "gzd", desc = "Delete surrounding" },
    },
    config = function()
      require("mini.surround").setup()
    end
  }
}
