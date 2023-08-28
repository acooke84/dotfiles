local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- Faster esc from insert mode
keymap("i", "jk", "<esc>", default_opts)
keymap("t", "jk", "<C-\\><C-n>", default_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)
