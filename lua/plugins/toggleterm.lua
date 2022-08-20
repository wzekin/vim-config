local M = { "akinsho/toggleterm.nvim" }

M.disable = false

M.tag = 'v2.*'

function M.config()
  require("toggleterm").setup {
    open_mapping = [[<c-\>]],

    -- winbar = {
    --   enable = true,
    --   name_formatter = function(term) --  term: Terminal
    --     return term.name
    --   end
    -- }
  }

end

return M
