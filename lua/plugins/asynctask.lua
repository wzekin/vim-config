local M = { "skywind3000/asynctasks.vim" }

M.disable = false

M.requires = {
  "skywind3000/asyncrun.vim"
}

function M.config()
  vim.g.asyncrun_open = 6
end

return M
