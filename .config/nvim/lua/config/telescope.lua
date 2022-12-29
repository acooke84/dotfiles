local M = {}

function M.setup()
  local status_ok, telescope = pcall(require, 'telescope')
  if not status_ok then
    return
  end

  local actions = require('telescope.actions')

  telescope.setup {
    find_command = {
    },
    use_less = true,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
        },
      }
    },
  }
end

return M
