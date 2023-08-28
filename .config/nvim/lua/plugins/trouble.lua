return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  opts = { use_diagnostic_signs = true },
  keys = {
    { "<leader>lt", "<cmd>TroubleToggle<cr>", desc = "TroubleToggle" },
  }
}
