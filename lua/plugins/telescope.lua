local M = {[1] = "nvim-telescope/telescope.nvim"}

M.requires = {"nvim-lua/plenary.nvim"}

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
        }
      }
    }
  }
end

return M
