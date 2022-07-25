local M = { "antoinemadec/FixCursorHold.nvim" }

M.disable = false

function M.setup()
  vim.g.cursorhold_updatetime = 500
end

return M
