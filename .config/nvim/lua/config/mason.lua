local M = {}

M.setup = function()
  local status_ok, mason = pcall(require, "mason")
  if not status_ok then
    return
  end

  local config = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  }

  mason.setup(config)
end

return M
