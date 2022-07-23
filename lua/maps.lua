local M = {}
local insertConfig = { { from = "jk", to = "<Esc>" }, { from = "kj", to = "<C-o>" } }
local normalConfig = {
  -- 快速关闭
  { from = "<leader>qq", to = ":wqa<CR>" },
  -- 快速切换窗口
  { from = "<Tab>", to = "<C-w>w" },
  { from = "<leader><Tab>", to = "<C-^>" },
  -- 窗口
  -- 文件查找
  { from = "<leader>k", to = "<cmd>Telescope keymaps<cr>" },
}

function M.setup()
  for _, i in ipairs(insertConfig) do
    local options = i.options or { silent = true }
    vim.api.nvim_set_keymap("i", i.from, i.to, options)
  end
  for _, n in ipairs(normalConfig) do
    local options = n.options or { silent = true }
    vim.api.nvim_set_keymap("n", n.from, n.to, options)
  end
  -- for _, n in ipairs(visualConfig) do
  --   local options = n.options or {silent = true}
  --   vim.api.nvim_set_keymap("v", n.from, n.to, options)
  -- end

  -- if you only want these mappings for toggle term use term://*toggleterm#* instead
  vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
end

return M
