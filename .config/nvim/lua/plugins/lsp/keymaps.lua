local M = {}

M._keymaps = nil

function M.get()
  if not M._keymaps then
    M._keymaps = {
      { "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
      { "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition", has = "definition" },
      { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
      { "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
      { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
      { "]d", M.diagnostic_goto(true), desc = "Next Diagnostic" },
      { "[d", M.diagnostic_goto(false), desc = "Prev Diagnostic" },
      { "]e", M.diagnostic_goto(true, "ERROR"), desc = "Next Error" },
      { "[e", M.diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
      { "]w", M.diagnostic_goto(true, "WARN"), desc = "Next Warning" },
      { "[w", M.diagnostic_goto(false, "WARN"), desc = "Prev Warning" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
    }
  end

  return M._keymaps
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function() go({ severity = severity }) end
end

function M.has(buffer, method)
  method = method:find("/") and method or "textDocument/" .. method
  local clients = vim.lsp.get_active_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

function M.resolve(buffer)
  local keymaps = {}
  local lazycore_keys = require("lazy.core.handler.keys")

  local function add(keymap)
    local keys = lazycore_keys.parse(keymap)
    if keys[2] == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end

  for _, keymap in ipairs(M.get()) do
    add(keymap)
  end

  return keymaps
end

function M.on_attach(client, buffer)
  local lazycore_keys = require("lazy.core.handler.keys")
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    if not lazycore_keys.has or M.has(buffer) then
      local opts = lazycore_keys.opts(keys)
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
    end
  end
end

return M
