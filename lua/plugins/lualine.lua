local M = {"hoob3rt/lualine.nvim"}

M.requires = {"kyazdani42/nvim-web-devicons", "navarasu/onedark.nvim"}

function M.config()
  require('lualine').setup({options = {theme = 'onedark'}})
end

return M
