local M = {}

local options = {
  termguicolors = true,
  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
  wildmenu = true,
  hidden = true,
  background = "dark",
  laststatus = 2,
  number = true,
  cursorline = true,
  cursorcolumn = true,
  hlsearch = true,
  foldlevel= 20,
  foldcolumn = "0",
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
  history = 2000,
  undolevels = 1000,
  undoreload = 10000,
  undofile = true,
  -- incsearch = true,
  completeopt = {"menuone","noselect"},
}

function M.setup()
  for key, value in pairs(options) do
    if type(key) == "string" then
      vim.opt[key] = value
    end
  end
end

return M
