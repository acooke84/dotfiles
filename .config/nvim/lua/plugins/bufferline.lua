return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      mode = "tabs",
      diagnostics = "nvim_lsp",
      numbers = "both",
      diagnostics_indicator = function(_, _, diag)
        local icons = require("config.icons").diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. " " or "") .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      separator_style = "slant",
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
  end
}
