local M = {"nvim-treesitter/nvim-treesitter"}

M.run = ":TSUpdate"

M.requires = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  "RRethy/nvim-treesitter-textsubjects"
}

function M.config()
  local config = require("nvim-treesitter.configs")
  config.setup({
    ensure_installed = "maintained",
    highlight = {enable = true},
    indent = {enable = true},
    autopairs = {enable = true},
    rainbow = {enable = true, extended_mode = true, max_file_lines = 1000},
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          af = "@function.outer",
          ["if"] = "@function.inner",
          ac = "@class.outer",
          ic = "@class.inner"
        }
      }
    },
    textsubjects = {
      enable = true,
      keymaps = {
        ["."] = "textsubjects-smart",
        [";"] = "textsubjects-container-outer"
      }
    }
  })
end

return M
