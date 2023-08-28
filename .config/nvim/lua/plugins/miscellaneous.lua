return {
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    cmd = "MarkdownPreview",
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "|",
      filetype_exclude = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleter"
      },
    },
    show_trailing_blankline_indent = false,
    show_current_context = false,
  },
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
  { "nvim-tree/nvim-web-devicons" },
  { "MunifTanjim/nui.nvim", lazy = true },
}
