-- Install lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
local lazy_config = {
  spec = {
    { import = "plugins" }
  },
  defaults = { lazy = false, version = nil },
  install = { missing = true, colorscheme = { "gruvbox" } },
}

require("lazy").setup(lazy_config)
vim.keymap.set("n", "<leader>zz", "<cmd>:Lazy<cr>", { desc = "Manage Plugins" })

