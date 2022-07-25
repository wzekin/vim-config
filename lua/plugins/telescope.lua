local M = { [1] = "nvim-telescope/telescope.nvim" }

M.disable = false

M.requires = {
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope-smart-history.nvim",
  "GustavoKatel/telescope-asynctasks.nvim",
  "tami5/sqlite.lua",
  { 'nvim-telescope/telescope-ui-select.nvim', branch = 'master' },
  { "nvim-telescope/telescope-fzf-native.nvim", run = 'make' }
}

function M.config()
  local actions = require "telescope.actions"
  require('telescope').setup {
    defaults = {
      mappings = {
        i = {
          ["<Tab>"] = actions.move_selection_worse,
          ["<S-Tab>"] = actions.move_selection_better
        },
        n = {
          ["<Tab>"] = actions.move_selection_worse,
          ["<S-Tab>"] = actions.move_selection_better
        },
      },
      history = {
        path = '~/.local/share/nvim/telescope_history.sqlite3',
        limit = 100,
      }
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {
          -- even more opts
        }

        -- pseudo code / specification for writing custom displays, like the one
        -- for "codeactions"
        -- specific_opts = {
        --   [kind] = {
        --     make_indexed = function(items) -> indexed_items, width,
        --     make_displayer = function(widths) -> displayer
        --     make_display = function(displayer) -> function(e)
        --     make_ordinal = function(e) -> string
        --   },
        --   -- for example to disable the custom builtin "codeactions" display
        --      do the following
        --   codeactions = false,
        -- }
      }
    }
  }

  require('telescope').load_extension('smart_history')
  require('telescope').load_extension('fzf')
  require("telescope").load_extension("ui-select")
end

return M
