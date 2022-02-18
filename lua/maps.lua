local M = {}
local insertConfig = {
  {from = "jk", to = "<Esc>"},
  {from = "kj", to = "<C-o>"}
}
local normalConfig = {
  -- 快速关闭
  {from = "<leader>qq", to = ":wqa<CR>"},
  --  切换BUFFER
  {from = "<leader>bl", to = ":ls<CR>"},
  {from = "<leader>bn", to = ":BufferLineCycleNext<CR>"},
  {from = "<leader>bp", to = ":BufferLineCyclePrev<CR>"},
  {from = "<leader>bd", to = ":bd<CR>"},
  {from = "<leader>bc", to = ":lua CloseAllSavedBuffer()<CR>"},
  {from = "<leader>bb", to = ":BufferLinePick<CR>"},
  -- 快速切换窗口
  {from = "<Tab>", to = "<C-w>w"},
  {from = "<leader><Tab>", to = "<C-^>"},
  -- 窗口
  {from = "<leader>d", to = ":NvimTreeToggle<CR>"},
  -- 快速暂停窗口并保存
  {from = "<leader>s", to = ":lua SaveAndPause()<CR>"},
  -- 文件查找
  {from = "<leader>ff", to = "<cmd>Telescope find_files<cr>"},
  {from = "<leader>fb", to = "<cmd>Telescope buffers<cr>"},
  {from = "<leader>fg", to = "<cmd>Telescope live_grep<cr>"},
  {from = "<leader>ft", to = "<cmd>Telescope treesitter<cr>"},
  {from = "<leader>k", to = "<cmd>Telescope keymaps<cr>"},
  {from = "<leader>p", to = "<cmd>Telescope projects<cr>"},
  {from = "<leader>t", to = "<cmd>Telescope builtin<cr>"},
  -- LSP 相关
  {from = "<leader>ld", to = "<cmd>Telescope diagnostics bufnr=0<cr>"},
  {from = "<leader>lD", to = "<cmd>Telescope diagnostics<cr>"},
  {from = "gl", to = "<cmd>Telescope lsp_code_actions theme=get_cursor<cr>"},
  {from = "gr", to = "<cmd>Telescope lsp_references<CR>"},
  {from = "gd", to = "<Cmd>Telescope lsp_definitions<CR>"},
  {from = "gi", to = "<cmd>Telescope lsp_implementations<CR>"},
  {from = "K", to = "<Cmd>lua vim.lsp.buf.hover()<CR>"},
  {from = "<C-k>", to = "<cmd>lua vim.lsp.buf.signature_help()<CR>"},
  {from = "<leader>wa", to = "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>"},
  {from = "<leader>wr", to = "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>"},
  {from = "<leader>wl", to = "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>"},
  {from = "<leader>D", to = "<cmd>lua vim.lsp.buf.type_definition()<CR>"},
  {from = "<leader>rn", to = "<cmd>lua vim.lsp.buf.rename()<CR>"},
  {from = "<leader>e", to = "<cmd>lua vim.diagnostic.open_float(0, { scope = \"line\", border = \"single\" })<CR>"},
  {from = "[d", to = "<cmd>lua vim.diagnostic.goto_prev()<CR>"},
  {from = "]d", to = "<cmd>lua vim.diagnostic.goto_next()<CR>"},
  -- 字符查找
  --[[ {from = "f", to = "<Plug>(easymotion-f)"},
    {from = "F", to = "<Plug>(easymotion-F)"},
    {from = "t", to = "<Plug>(easymotion-t)"},
    {from = "T", to = "<Plug>(easymotion-T)"},
    {from = "<leader>j", to = "<Plug>(easymotion-j)"},
    {from = "<leader>k", to = "<Plug>(easymotion-k)"}, ]]
  -- 注释
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
