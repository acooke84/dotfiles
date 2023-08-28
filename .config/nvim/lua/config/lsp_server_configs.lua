return {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
        diagnostics = { globals = { "vim", "describe", "it", "before_each", "after_each", "packer_plugins" } },
      }
    }
  },
  clangd = {},
  cmake = {},
  jsonls = {},
  tsserver = {},
  pyright = {},
  sqlls = {},
}
