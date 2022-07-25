local M = { "numToStr/Comment.nvim" }

M.disable = false

function M.config()
  require("Comment").setup()
end

return M
