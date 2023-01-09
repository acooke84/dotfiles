local M = {}

local ls = require('luasnip')

M.setup = function()
  ls.config.set_config {
    history = true,
    updateevents = 'TextChanged,TextChangedI',
  }
end

return M
