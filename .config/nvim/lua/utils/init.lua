local M = {}

function M.has(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

function M.lsp_server_configs()
  return require("config.lsp_server_configs")
end

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

function M.opts(plugin_name)
  local plugin = require("lazy.core.config").plugins[plugin_name]
  if not plugin then
    return {}
  end
  return require("lazy.core.plugin").values(plugin, "opts", false)
end

function M.quit(session)
  local quit_cmd = "q" .. (session and "a" or "") .. "!"
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_windows = vim.call("win_findbuf", bufnr)
  local modified = vim.api.nvim_get_option_value("modified", { buf = bufnr })
  if modified and #buf_windows == 1 then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/n) ",
    }, function(input)
      if input == "y" then
        vim.cmd(quit_cmd)
      end
    end)
  else
    vim.cmd(quit_cmd)
  end
end

return M
