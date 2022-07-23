local M = { "akinsho/toggleterm.nvim" }

M.tag = 'v2.*'

function M.config()
  require("toggleterm").setup {
    open_mapping = [[<c-\>]],
    terminal_mappings = true,

    winbar = {
      enable = true,
      name_formatter = function(term) --  term: Terminal
        return "1"
      end
    }
  }

end

return M
