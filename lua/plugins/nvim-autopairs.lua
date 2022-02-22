local M = {"windwp/nvim-autopairs"}

function M.config()
  require("nvim-autopairs").setup({
    disable_filetype = {"TelescopePrompt", "vim"}
  })
end

return M
