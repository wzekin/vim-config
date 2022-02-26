local M = {}
local insertConfig = {{from = "jk", to = "<Esc>"}, {from = "kj", to = "<C-o>"}}
local normalConfig = {
  -- 快速关闭
  {from = "<leader>qq", to = ":wqa<CR>"},
  -- 快速切换窗口
  {from = "<Tab>", to = "<C-w>w"},
  {from = "<leader><Tab>", to = "<C-^>"},
  -- 窗口
  -- 文件查找
  {from = "<leader>ft", to = "<cmd>Telescope treesitter<cr>"},

  {from = "<leader>k", to = "<cmd>Telescope keymaps<cr>"},
  -- LSP 相关
  {from = "gr", to = "<cmd>Telescope lsp_references<CR>"},
  {from = "gd", to = "<Cmd>Telescope lsp_definitions<CR>"},
  {from = "gi", to = "<cmd>Telescope lsp_implementations<CR>"},

  {from = "=G", to = "<cmd>lua vim.lsp.buf.formatting()<CR>"}
}

function M.init_maps()
  for _, i in ipairs(insertConfig) do
    local options = i.options or {silent = true}
    vim.api.nvim_set_keymap("i", i.from, i.to, options)
  end
  for _, n in ipairs(normalConfig) do
    local options = n.options or {silent = true}
    vim.api.nvim_set_keymap("n", n.from, n.to, options)
  end
  -- for _, n in ipairs(visualConfig) do
  --   local options = n.options or {silent = true}
  --   vim.api.nvim_set_keymap("v", n.from, n.to, options)
  -- end
end

return M
