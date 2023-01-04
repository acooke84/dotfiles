local M = {}

function M.setup()
  local status_ok, telescope = pcall(require, 'telescope')
  if not status_ok then
    return
  end

  local actions = require('telescope.actions')

  local options = {
    defaults = {
      vimgrep_arguments = {
      	"rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
          "--column",
          "--smart-case",
      },
      sorting_strategy = "descending",
      selection_strategy = "reset",
      scroll_strategy = "cycle",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "bottom",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.8,
        preview_cutoff = 120,
      },
      windblend = 0,
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      border = {},
      path_display = { "truncate" },
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      set_env = { COLORTERM = "truecolor" },
      color_devicons = true,
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      file_ignore_patters = { "node_modules" },
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        n = { ["q"] = actions.close },
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
        },
      },
    },
    extensions_list = {  },
  }

  telescope.setup(options)

  pcall(function()
    for _, ext in pairs(options.extensions_list) do
      telescope.load_extension(ext)
    end
  end)
end

return M
