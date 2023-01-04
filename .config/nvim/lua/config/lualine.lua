local M = {}

local config = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    globalstatus = true,
    component_separators = {},
    section_separators = {},
    disabled_filetypes = {
      statusline = {},
      winbar = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "alpha",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "dap-repl",
        "dapui_console",
        "dapui_watches",
        "dapui_stacks",
        "dapui_breakpoints",
        "dapui_scopes",
      },
    },
    always_divide_middle = true,
    globalstatus = true,
  },
}


M.setup = function()
  local status_ok, lualine = pcall(require, 'lualine')
  if not status_ok then
    return
  end

  lualine.setup(config)
end

return M
